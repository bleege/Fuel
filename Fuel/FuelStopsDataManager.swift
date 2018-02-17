//
//  FuelStopsDataManager.swift
//  Fuel
//
//  Created by Brad Leege on 12/2/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import CoreData

class FuelStopsDataManager {
    
    var persistentContainer: NSPersistentContainer
    
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "FuelStops")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
    
    func getAllFuelStops() -> [FuelStopsMO] {
        let allStopsRequest = NSFetchRequest<FuelStopsMO>(entityName: "FuelStops")
        let sort = NSSortDescriptor(key: "stop_date", ascending: false)
        allStopsRequest.sortDescriptors = [sort]
        
        do {
            return try persistentContainer.viewContext.fetch(allStopsRequest)
        } catch {
            fatalError("Error loading FuelStops: \(error)")
        }
    }
    
    func deleteFuelStop(fuelStop: FuelStopsMO) {
        persistentContainer.viewContext.delete(fuelStop)
    }
    
    func deleteAllFuelStops() {
        let stops = getAllFuelStops()
            
        for fuelStop in stops {
            persistentContainer.viewContext.delete(fuelStop)
        }
    }
    
    func addFuelStop(fuelStop: FuelStopsMO) {
        persistentContainer.viewContext.insert(fuelStop)
    }
    
    func addFuelStop(gallons: Double, latitude: Double, longitude: Double, octane: Int,
                     odometer: Int, price: Double, ppg: Double, stopDate: Date, tripOdometer: Double) {
        
        let stop = getNewStop()
        
        stop.gallons = gallons
        stop.latitude = latitude
        stop.longitude = longitude
        stop.mpg = tripOdometer / gallons
        stop.octane = Int16(octane)
        stop.odometer = Int16(odometer)
        stop.price = price
        stop.price_per_gallon = ppg
        stop.stop_date = stopDate
        stop.trip_odometer = tripOdometer
        
        persistentContainer.viewContext.insert(stop)
    }
    
    func addFuelStop(csv: [String]) {
        let stop = getNewStop()
        
        let df: DateFormatter = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
        
        stop.gallons = Double(csv[4])!
        stop.latitude = Double(csv[1])!
        stop.longitude = Double(csv[2])!
        stop.mpg = Double(csv[9])!
        stop.octane = Int16(csv[3])!
        stop.odometer = Int16(csv[8])!
        stop.price = Double(csv[6].replacingOccurrences(of: "$", with: ""))!
        stop.price_per_gallon = Double(csv[5])!
        stop.stop_date = df.date(from: csv[0])!
        stop.trip_odometer = Double(csv[7])!

        persistentContainer.viewContext.insert(stop)
    }
    
    private func getNewStop() -> FuelStopsMO {
        let stop = FuelStopsMO.init(entity: NSEntityDescription.entity(forEntityName: "FuelStops", in: persistentContainer.viewContext)!, insertInto: persistentContainer.viewContext) as FuelStopsMO
        stop.fuelstops_id = UUID()
        return stop
    }
}
