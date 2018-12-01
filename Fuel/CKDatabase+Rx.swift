//
//  CKDatabase+Rx.swift
//  Fuel
//
//  Created by Brad Leege on 11/28/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CloudKit
import RxSwift

extension CKDatabase {
    
    func fetchAll(recordType: String, sortDescriptors: [NSSortDescriptor]) -> Observable<[CKRecord]> {
        let query:CKQuery = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        query.sortDescriptors = sortDescriptors
        
        return Observable<[CKRecord]>.create { observer in
            self.perform(query, inZoneWith: nil, completionHandler: { (records, error) in

                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(records!)
                    observer.onCompleted()
                }
            })

            return Disposables.create {
                // No Op
            }
        }
    }
}
