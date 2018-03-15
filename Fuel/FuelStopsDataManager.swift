//
//  FuelStopsDataManager.swift
//  Fuel
//
//  Created by Brad Leege on 12/2/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import CoreData
import CloudKit

class FuelStopsDataManager {
    
    let container: CKContainer
    let userDB: CKDatabase
    let FuelStopType = "FuelStop"
    
    init() {
        container = CKContainer.default()
        userDB = container.privateCloudDatabase
    }
    
    
    func getAllFuelStops() -> [FuelStop] {

//        let predicate = NSPredicate()
//        let query = CKQuery(recordType: FuelStopType, predicate: predicate)
//        
//        var stops = [FuelStop]()
        
//        userDB.perform(query, inZoneWith: nil, completionHandler: { results, error in
//            if let error = error {
//                fatalError("Error loading FuelStops: \(error)")
//                return
//            }
//
//
//        })
     
        return [FuelStop]()
    }
    
    func deleteFuelStop(fuelStop: FuelStopsMO) {
//        persistentContainer.viewContext.delete(fuelStop)
    }
    
    func deleteAllFuelStops() {
        let stops = getAllFuelStops()
            
        for fuelStop in stops {
//            persistentContainer.viewContext.delete(fuelStop)
        }
    }
    
    func addFuelStop(fuelStop: FuelStopsMO) {
//        persistentContainer.viewContext.insert(fuelStop)
    }
    
    func addFuelStop(gallons: Double, latitude: Double, longitude: Double, octane: Int,
                     odometer: Int, price: Double, ppg: Double, stopDate: Date, tripOdometer: Double) {
        
//        let stop = FuelStop()
        
//        stop.gallons = gallons
//        stop.latitude = latitude
//        stop.longitude = longitude
//        stop.mpg = tripOdometer / gallons
//        stop.octane = Int16(octane)
//        stop.odometer = Int16(odometer)
//        stop.price = price
//        stop.price_per_gallon = ppg
//        stop.stop_date = stopDate
//        stop.trip_odometer = tripOdometer
        
//        persistentContainer.viewContext.insert(stop)
    }
    
    func addFuelStop(csv: [String]) {
//        let stop = FuelStop()
        
//        let df: DateFormatter = DateFormatter()
//        df.locale = Locale(identifier: "en_US")
//        df.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
//
//        stop.gallons = Double(csv[4])!
//        stop.latitude = Double(csv[1])!
//        stop.longitude = Double(csv[2])!
//        stop.mpg = Double(csv[9])!
//        stop.octane = Int16(csv[3])!
//        stop.odometer = Int16(csv[8])!
//        stop.price = Double(csv[6].replacingOccurrences(of: "$", with: ""))!
//        stop.price_per_gallon = Double(csv[5])!
//        stop.stop_date = df.date(from: csv[0])!
//        stop.trip_odometer = Double(csv[7])!

//        persistentContainer.viewContext.insert(stop)
    }
}
