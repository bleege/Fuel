//
//  AppDelegate.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    let dataManager = FuelStopsDataManager()
    private let locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupLocationManager()
        
//        preloadData()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func preloadData() {
        
        guard let filePath = Bundle.main.path(forResource: "2016-VW-Jetta-Fuel-Tracking", ofType: ".csv")
            else {
                print("Couldn't load data file")
                return
        }
        
        do {
            let csvContent = try String(contentsOfFile: filePath, encoding: .utf8)
            print(csvContent)
            let lines: [String] = csvContent.components(separatedBy: .newlines)
            
            for line in lines {
                let values = line.components(separatedBy: ",")
                if (values.count > 1) {
                    dataManager.addFuelStop(csv: values).subscribe()
                }
            }
            
        } catch {
            print("Couldn't load data file")
            return
        }
        
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == .denied) {
            let controller = UIAlertController(title: "Location Required", message: "The app needs this permission to find the fuel stations.",  preferredStyle: .alert)
            let yesButton = UIAlertAction(title:"Ok", style: UIAlertActionStyle.default, handler:nil);
            controller.addAction(yesButton)
            self.window?.rootViewController?.present(controller, animated: true) { }
        }
    }

}

