//
//  FuelStop.swift
//  Fuel
//
//  Created by Brad Leege on 3/11/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CloudKit
import CoreLocation

struct FuelStop {

    let gallons: Double
    let location: CLLocation
    let mpg: Double
    let octane: Int64
    let odometer: Int64
    let price: Double
    let pricePerGallon: Double
    let stopDate: Date
    let tripOdometer: Double
    let recordName: String
    
    init(record: CKRecord) {
        gallons = record.object(forKey: "gallons") as! Double
        location = record.object(forKey: "location") as! CLLocation
        mpg = record.object(forKey: "mpg") as! Double
        octane = record.object(forKey: "octane") as! Int64
        odometer = record.object(forKey: "odometer") as! Int64
        price = record.object(forKey: "price") as! Double
        pricePerGallon = record.object(forKey: "price_per_gallon") as! Double
        stopDate = record.object(forKey: "stop_date") as! Date
        tripOdometer = record.object(forKey: "trip_odometer") as! Double
        recordName = record.recordID.recordName
    }
}
