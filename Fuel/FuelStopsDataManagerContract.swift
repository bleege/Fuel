//
//  FuelStopsDataManagerContract.swift
//  Fuel
//
//  Created by Brad Leege on 5/26/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation
import CloudKit
import Combine

protocol FuelStopsDataManagerContract: AnyObject {

    func getAllFuelStops() -> AnyPublisher<[CKRecord], Error>
    
    func deleteFuelStop(fuelStop: FuelStop)
    
    func addFuelStop(fuelStop: FuelStop) -> AnyPublisher<CKRecord, Error>
    
    func addFuelStop(gallons: Double, latitude: Double, longitude: Double, octane: Int,
                     odometer: Int, price: Double, ppg: Double, stopDate: Date, tripOdometer: Double) -> AnyPublisher<CKRecord, Error>
    
    func addFuelStop(csv: [String]) -> AnyPublisher<CKRecord, Error>
}
