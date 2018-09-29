//
//  CKRecord+Rx.swift
//  RxCloudKit
//
//  Created by Maxim Volgin on 25/06/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import RxSwift
import CloudKit

public extension Reactive where Base: CKRecord {
    
    public func save(in database: CKDatabase) -> Maybe<CKRecord> {
        return Maybe<CKRecord>.create { maybe in
            database.save(self.base) { (result, error) in
                if let error = error {
                    maybe(.error(error))
                    return
                }
                guard result != nil else {
                    maybe(.completed)
                    return
                }
                maybe(.success(result!))
            }
            return Disposables.create()
        }
    }

    public static func fetch(with recordID: CKRecordID, in database: CKDatabase) -> Maybe<CKRecord> {
        return Maybe<CKRecord>.create { maybe in
            database.fetch(withRecordID: recordID) { (record, error) in
                if let error = error {
                    maybe(.error(error))
                    return
                }
                guard record != nil else {
                    maybe(.completed)
                    return
                }
                maybe(.success(record!))
            }
            return Disposables.create()
        }
    }

    public static func delete(with recordID: CKRecordID, in database: CKDatabase) -> Maybe<CKRecordID> {
        return Maybe<CKRecordID>.create { maybe in
            database.delete(withRecordID: recordID) { (recordID, error) in
                if let error = error {
                    maybe(.error(error))
                    return
                }
                guard recordID != nil else {
                    maybe(.completed)
                    return
                }
                maybe(.success(recordID!))
            }
            return Disposables.create()
        }
    }

    public static func fetch(recordType: String, predicate: NSPredicate = NSPredicate(value: true), sortDescriptors: [NSSortDescriptor]? = nil, limit: Int = 400, in database: CKDatabase) -> Observable<CKRecord> {
        return Observable.create { observer in
            let query = CKQuery(recordType: recordType, predicate: predicate)
            query.sortDescriptors = sortDescriptors
            _ = RecordFetcher(observer: observer, database: database, query: query, limit: limit)
            return Disposables.create()
        }
    }
    
    public static func fetchChanges(recordZoneIDs: [CKRecordZoneID], optionsByRecordZoneID: [CKRecordZoneID : CKFetchRecordZoneChangesOptions]? = nil, in database: CKDatabase) -> Observable<RecordEvent> {
        return Observable.create { observer in
            _ = RecordChangeFetcher(observer: observer, database: database, recordZoneIDs: recordZoneIDs, optionsByRecordZoneID: optionsByRecordZoneID)
            return Disposables.create()
        }
    }
    
    public static func modify(recordsToSave records: [CKRecord]?, recordIDsToDelete recordIDs: [CKRecordID]?, in database: CKDatabase) -> Observable<RecordModifyEvent> {
        return Observable.create { observer in
            _ = RecordModifier(observer: observer, database: database, recordsToSave: records, recordIDsToDelete: recordIDs)
            return Disposables.create()
        }
    }

}
