//
//  CKDatabase+Rx.swift
//  Fuel
//
//  Created by Brad Leege on 11/28/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CloudKit
import RxSwift
import Combine

extension CKDatabase {
    
    func fetchAll(recordType: String, sortDescriptors: [NSSortDescriptor]) -> AnyPublisher<[CKRecord], Error> {
        let query:CKQuery = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        query.sortDescriptors = sortDescriptors

        return Deferred {
            Future { promise in
                self.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(records!))
                    }
                })
            }
        }.eraseToAnyPublisher()
    }
    
    func save(stop: CKRecord) -> Maybe<CKRecord> {

        return Maybe<CKRecord>.create { [weak self] maybe in
            self?.save(stop, completionHandler: { (record, error) in
                if let error = error {
                    maybe(.error(error))
                } else {
                    maybe(.success(record!))
                }
            })
            return Disposables.create { }
        }
    }
}
