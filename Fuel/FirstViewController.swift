//
//  FirstViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fuelStops = dataManager.getAllFuelStops()
        print("number of fuelStops found = \(fuelStops.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
