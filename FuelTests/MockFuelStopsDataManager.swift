//
//  MockFuelStopsDataManager.swift
//  FuelTests
//
//  Created by Brad Leege on 5/26/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation
import CloudKit
import Combine
@testable import Fuel

class MockFuelStopsDataManager: FuelStopsDataManagerContract {
    func getAllFuelStops() -> AnyPublisher<[CKRecord], Error> {
        let record = [CKRecord(recordType: "FuelStop")]
        return Future { promise in
            promise(.success(record))
        }.eraseToAnyPublisher()
    }
    
    func deleteFuelStop(fuelStop: FuelStop) {
        // No Op
    }
    
    func addFuelStop(fuelStop: FuelStop) -> AnyPublisher<CKRecord, Error> {
        let record = CKRecord(recordType: "FuelStop")
        
        return Future { promise in
            promise(.success(record))
        }.eraseToAnyPublisher()
    }
    
    func addFuelStop(gallons: Double, latitude: Double, longitude: Double, octane: Int, odometer: Int, price: Double, ppg: Double, stopDate: Date, tripOdometer: Double) -> AnyPublisher<CKRecord, Error> {
        let record = CKRecord(recordType: "FuelStop")
        return Future { promise in
            promise(.success(record))
        }.eraseToAnyPublisher()
    }
    
    func addFuelStop(csv: [String]) -> AnyPublisher<CKRecord, Error> {
        let record = CKRecord(recordType: "Test Record Added From CSV")
        return Future { promise in
            promise(.success(record))
        }.eraseToAnyPublisher()
    }
}
