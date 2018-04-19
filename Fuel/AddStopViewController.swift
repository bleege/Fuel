//
//  SecondViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import CoreLocation
import UIKit

class AddStopViewController: UIViewController, AddStopContractView {

    var presenter: AddStopContractPresenter?
    
    @IBOutlet weak var pricePerGallon: UITextField!
    @IBOutlet weak var gallons: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var octane: UITextField!
    @IBOutlet weak var tripOdometer: UITextField!
    @IBOutlet weak var tripMPG: UITextField!
    @IBOutlet weak var odometer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = AddStopPresenter()
        
//        let errorColor = UIColor.red
//
//        pricePerGallon.placeholder = "Price per Gallon"
//        pricePerGallon.title = "Price per Gallon"
//        pricePerGallon.errorColor = errorColor
//        gallons.placeholder = "Gallons"
//        gallons.title = "Gallons"
//        gallons.errorColor = errorColor
//        cost.placeholder = "Cost"
//        cost.title = "Cost"
//        cost.errorColor = errorColor
//        octane.placeholder = "Octane"
//        octane.title = "Octane"
//        octane.errorColor = errorColor
//        tripOdometer.placeholder = "Trip Odometer"
//        tripOdometer.title = "Trip Odometer"
//        tripOdometer.errorColor = errorColor
//        odometer.placeholder = "Odometer"
//        odometer.title = "Odometer"
//        odometer.errorColor = errorColor
//        initialDataPopulation()
        
        // Dismiss Keyboard Input
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onAttach(view: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.onDetach()
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSaveTap(_ sender: Any) {
        presenter?.handleSaveTap()
    }
    @IBAction func handleCancelTap(_ sender: Any) {
        presenter?.handleCancelTap()
    }
    
    // MARK: AddStopContractView
    
    func initialDataPopulation() {
        self.pricePerGallon.text = ""
        self.gallons.text = ""
        self.cost.text = ""
        self.octane.text = ""
        self.tripOdometer.text = ""
        self.odometer.text = ""
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
    
    func dismissAfterSave(record: FuelStop) {
        if (self.presentingViewController != nil) {
            print("presentingViewController is not null")
            (self.presentingViewController as! OverviewViewController).addFuelStopToTable(fuelStop: record)
            dismiss()
        }
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Whoops", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validateForm() -> Bool {
        
        var isValid = true
        
//        if (pricePerGallon.text?.isEmpty)! {
//            isValid = false
//            pricePerGallon.errorMessage = "Error"
//        } else {
//            pricePerGallon.errorMessage = ""
//        }
//
//        if (gallons.text?.isEmpty)! {
//            isValid = false
//            gallons.errorMessage = "Error"
//        } else {
//            gallons.errorMessage = ""
//        }
//
//        if (cost.text?.isEmpty)! {
//            isValid = false
//            cost.errorMessage = "Error"
//        } else {
//            cost.errorMessage = ""
//        }
//
//        if (octane.text?.isEmpty)! {
//            isValid = false
//            octane.errorMessage = "Error"
//        } else {
//            octane.errorMessage = ""
//        }
//
//        if (tripOdometer.text?.isEmpty)! {
//            isValid = false
//            tripOdometer.errorMessage = "Error"
//        } else {
//            tripOdometer.errorMessage = ""
//        }
//
//        if (odometer.text?.isEmpty)! {
//            isValid = false
//            odometer.errorMessage = "Error"
//        } else {
//            odometer.errorMessage = ""
//        }
//        
        return isValid
    }
    
    func gallonsData() -> Double {
        return Double(gallons.text!)!
    }
    
    func octaneData() -> Int{
        return Int(octane.text!)!
    }
    
    func odometerData() -> Int{
        return Int(odometer.text!)!
    }
    
    func priceData() -> Double{
        return Double(cost.text!)!
    }
    
    func ppgData() -> Double{
        return Double(pricePerGallon.text!)!
    }
    
    func stopDateData() -> Date{
        return Date()
    }
    
    func tripOdometerData() -> Double{
        return Double(tripOdometer.text!)!
    }
}
