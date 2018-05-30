//
//  MockFuelStopsDataManager.swift
//  FuelTests
//
//  Created by Brad Leege on 5/26/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation
import CloudKit
import RxSwift
@testable import Fuel

class MockFuelStopsDataManager: FuelStopsDataManagerContract {
    func getAllFuelStops() -> Observable<CKRecord> {
        let record = CKRecord(recordType: "FuelStop")
        return Observable.just(record)
    }
    
    func deleteFuelStop(fuelStop: FuelStop) {
        // No Op
    }
    
    func addFuelStop(fuelStop: FuelStop) -> Maybe<CKRecord> {
        let record = CKRecord(recordType: "FuelStop")
        
        return Maybe<CKRecord>.create { maybe in
            maybe(.success(record))
            return Disposables.create {}
        }
    }
    
    func addFuelStop(gallons: Double, latitude: Double, longitude: Double, octane: Int, odometer: Int, price: Double, ppg: Double, stopDate: Date, tripOdometer: Double) -> Maybe<CKRecord> {
        let record = CKRecord(recordType: "FuelStop")
        return Maybe<CKRecord>.create { maybe in
            maybe(.success(record))
            return Disposables.create {}
        }
    }
    
    func addFuelStop(csv: [String]) -> Maybe<CKRecord> {
        let record = CKRecord(recordType: "Test Record Added From CSV")
        return Maybe<CKRecord>.create { maybe in
            maybe(.success(record))
            return Disposables.create {}
        }
    }
}
