//
//  FuelStopsDataManager.swift
//  Fuel
//
//  Created by Brad Leege on 12/2/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import CloudKit
import CoreLocation
import RxSwift

class FuelStopsDataManager {
    
    private let container: CKContainer
    private let userDB: CKDatabase
    private let FuelStopType = "FuelStop"
    private let stopsSortByDate = NSSortDescriptor(key: FuelStop.KEY_STOPDATE, ascending: false)
    
    init() {
        container = CKContainer.default()
        userDB = container.privateCloudDatabase
    }
    
    func getAllFuelStops() -> Observable<CKRecord>  {
        return userDB.rx.fetch(recordType: FuelStopType, sortDescriptors: [stopsSortByDate])
    }
    
    func deleteFuelStop(fuelStop: FuelStop) {
//        persistentContainer.viewContext.delete(fuelStop)
    }
    
    func addFuelStop(fuelStop: FuelStop) -> Maybe<CKRecord> {
        return addFuelStop(gallons: fuelStop.gallons, latitude: fuelStop.location.coordinate.latitude, longitude: fuelStop.location.coordinate.longitude, octane: Int(fuelStop.octane), odometer: Int(fuelStop.odometer), price: fuelStop.price, ppg: fuelStop.pricePerGallon, stopDate: fuelStop.stopDate, tripOdometer: fuelStop.tripOdometer)
    }
    
    func addFuelStop(gallons: Double, latitude: Double, longitude: Double, octane: Int,
                     odometer: Int, price: Double, ppg: Double, stopDate: Date, tripOdometer: Double) -> Maybe<CKRecord> {
 
        let stop = CKRecord(recordType: FuelStopType)
        stop.setValue(gallons, forKey: FuelStop.KEY_GALLONS)
        stop.setValue(CLLocation(latitude: latitude, longitude: longitude), forKey: FuelStop.KEY_LOCATION)
        stop.setValue(tripOdometer / gallons, forKey: FuelStop.KEY_MPG)
        stop.setValue(octane, forKey: FuelStop.KEY_OCTANE)
        stop.setValue(odometer, forKey: FuelStop.KEY_ODOMETER)
        stop.setValue(price, forKey: FuelStop.KEY_PRICE)
        stop.setValue(ppg, forKey: FuelStop.KEY_PPG)
        stop.setValue(stopDate, forKey: FuelStop.KEY_STOPDATE)
        stop.setValue(tripOdometer, forKey: FuelStop.KEY_TRIP_ODOMETER)
        
        return userDB.rx.save(record: stop)
    }
    
    func addFuelStop(csv: [String]) -> Maybe<CKRecord> {
        
        let df: DateFormatter = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")

        let gallons = Double(csv[4])!
        let latitude = Double(csv[1])!
        let longitude = Double(csv[2])!
        let octane = Int16(csv[3])!
        let odometer = Int16(csv[8])!
        let price = Double(csv[6].replacingOccurrences(of: "$", with: ""))!
        let price_per_gallon = Double(csv[5])!
        let stop_date = df.date(from: csv[0])!
        let trip_odometer = Double(csv[7])!

        return addFuelStop(gallons: gallons, latitude: latitude, longitude: longitude, octane: Int(octane), odometer: Int(odometer), price: price, ppg: price_per_gallon, stopDate: stop_date, tripOdometer: trip_odometer)
    }
}
