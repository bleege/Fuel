//
//  FuelStopsDataManagerContract.swift
//  Fuel
//
//  Created by Brad Leege on 5/26/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation
import CloudKit
import RxSwift

protocol FuelStopsDataManagerContract: class {

    func getAllFuelStops() -> Observable<CKRecord>
    
    func deleteFuelStop(fuelStop: FuelStop)
    
    func addFuelStop(fuelStop: FuelStop) -> Maybe<CKRecord>
    
    func addFuelStop(gallons: Double, latitude: Double, longitude: Double, octane: Int,
                     odometer: Int, price: Double, ppg: Double, stopDate: Date, tripOdometer: Double) -> Maybe<CKRecord>
    
    func addFuelStop(csv: [String]) -> Maybe<CKRecord>
}
