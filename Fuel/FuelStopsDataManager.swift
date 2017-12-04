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
}
