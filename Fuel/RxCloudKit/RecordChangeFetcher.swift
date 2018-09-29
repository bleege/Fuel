//
//  RecordChangeFetcher.swift
//  RxCloudKit
//
//  Created by Maxim Volgin on 11/08/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import RxSwift
import CloudKit

public enum RecordEvent {
    case changed(CKRecord)
    case deleted(CKRecordID)
    case token(CKRecordZoneID, CKServerChangeToken)
}

final class RecordChangeFetcher {
    
    typealias Observer = AnyObserver<RecordEvent>
    
    private let observer: Observer
    private let database: CKDatabase
    
    private let recordZoneIDs: [CKRecordZoneID]
    private var optionsByRecordZoneID: [CKRecordZoneID : CKFetchRecordZoneChangesOptions]
    
    init(observer: Observer, database: CKDatabase, recordZoneIDs: [CKRecordZoneID], optionsByRecordZoneID: [CKRecordZoneID : CKFetchRecordZoneChangesOptions]? = nil) {
        self.observer = observer
        self.database = database
        self.recordZoneIDs = recordZoneIDs
        self.optionsByRecordZoneID = optionsByRecordZoneID ?? [:]
        self.fetch()
    }
    
    // MARK:- callbacks
    
    private func recordChangedBlock(record: CKRecord) {
        self.observer.on(.next(.changed(record)))
    }
    
    private func recordWithIDWasDeletedBlock(recordID: CKRecordID, undocumented: String) {
        print("\(recordID)|\(undocumented)") // TEMP undocumented?
        self.observer.on(.next(.deleted(recordID)))
    }
    
    private func recordZoneChangeTokensUpdatedBlock(zoneID: CKRecordZoneID, serverChangeToken: CKServerChangeToken?, clientChangeTokenData: Data?) {
        self.updateToken(zoneID: zoneID, serverChangeToken: serverChangeToken)
        
        if let token = serverChangeToken {
            self.observer.on(.next(.token(zoneID, token)))
        }
        // TODO clientChangeTokenData?
    }
    
    private func recordZoneFetchCompletionBlock(zoneID: CKRecordZoneID, serverChangeToken: CKServerChangeToken?, clientChangeTokenData: Data?, moreComing: Bool, recordZoneError: Error?) {
        // TODO clientChangeTokenData ?
        if let error = recordZoneError {
            //            observer.on(.error(error)) // special handling for CKErrorChangeTokenExpired (purge local cache, fetch with token=nil)
            return
        }

        self.updateToken(zoneID: zoneID, serverChangeToken: serverChangeToken)

        if let token = serverChangeToken {
            self.observer.on(.next(.token(zoneID, token)))
        }
        
//        if moreComing {
//            self.fetch() // TODO only for this zone?
//            return
//        } else {
//            if let index = self.recordZoneIDs.index(of: zoneID) {
//                self.recordZoneIDs.remove(at: index)
//            }
//        }
    }
    
    private func fetchRecordZoneChangesCompletionBlock(operationError: Error?) {
        if let error = operationError {
            observer.on(.error(error))
            return
        }
        observer.on(.completed)
    }
    
    // MARK:- custom
    
    private func updateToken(zoneID: CKRecordZoneID, serverChangeToken: CKServerChangeToken?) {
        // token, limit, fields (nil = all, [] = no user fields)
        let options = self.optionsByRecordZoneID[zoneID] ?? CKFetchRecordZoneChangesOptions()
        options.previousServerChangeToken = serverChangeToken
        self.optionsByRecordZoneID[zoneID] = options
    }
    
    private func fetch() {
        let operation = CKFetchRecordZoneChangesOperation(recordZoneIDs: self.recordZoneIDs, optionsByRecordZoneID: self.optionsByRecordZoneID)
        operation.fetchAllChanges = true
        operation.qualityOfService = .userInitiated
        operation.recordChangedBlock = self.recordChangedBlock
        operation.recordWithIDWasDeletedBlock = self.recordWithIDWasDeletedBlock
        operation.recordZoneChangeTokensUpdatedBlock = self.recordZoneChangeTokensUpdatedBlock
        operation.recordZoneFetchCompletionBlock = self.recordZoneFetchCompletionBlock
        operation.fetchRecordZoneChangesCompletionBlock = self.fetchRecordZoneChangesCompletionBlock
        self.database.add(operation)
    }
    
}
