//
//  SecondViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit

class AddStopViewController: UIViewController {

    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var pricePerGalloon: UITextField!
    @IBOutlet weak var gallons: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var octane: UITextField!
    @IBOutlet weak var tripOdometer: UITextField!
    @IBOutlet weak var odometer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleCancelTap(_ sender: Any) {
        dismiss(animated: true)
    }
}
