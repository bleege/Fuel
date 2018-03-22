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
    
    static let KEY_GALLONS = "gallons"
    static let KEY_LOCATION = "location"
    static let KEY_MPG = "mpg"
    static let KEY_OCTANE = "octane"
    static let KEY_ODOMETER = "odometer"
    static let KEY_PRICE = "price"
    static let KEY_PPG = "price_per_gallon"
    static let KEY_STOPDATE = "stop_date"
    static let KEY_TRIP_ODOMETER = "trip_odometer"
    
    init(record: CKRecord) {
        gallons = record.object(forKey: FuelStop.KEY_GALLONS) as! Double
        location = record.object(forKey: FuelStop.KEY_LOCATION) as! CLLocation
        mpg = record.object(forKey: FuelStop.KEY_MPG) as! Double
        octane = record.object(forKey: FuelStop.KEY_OCTANE) as! Int64
        odometer = record.object(forKey: FuelStop.KEY_ODOMETER) as! Int64
        price = record.object(forKey: FuelStop.KEY_PRICE) as! Double
        pricePerGallon = record.object(forKey: FuelStop.KEY_PPG) as! Double
        stopDate = record.object(forKey: FuelStop.KEY_STOPDATE) as! Date
        tripOdometer = record.object(forKey: FuelStop.KEY_TRIP_ODOMETER) as! Double
        recordName = record.recordID.recordName
    }
}
