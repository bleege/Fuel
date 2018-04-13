//
//  SecondViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import CoreLocation
import UIKit
import SkyFloatingLabelTextField

class AddStopViewController: UIViewController, AddStopContractView {

    var presenter: AddStopContractPresenter?
    
    @IBOutlet weak var pricePerGalloon: SkyFloatingLabelTextField!
    @IBOutlet weak var gallons: SkyFloatingLabelTextField!
    @IBOutlet weak var cost: SkyFloatingLabelTextField!
    @IBOutlet weak var octane: SkyFloatingLabelTextField!
    @IBOutlet weak var tripOdometer: SkyFloatingLabelTextField!
    @IBOutlet weak var odometer: SkyFloatingLabelTextField!
    
    private var stopLocation: CLLocation?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = AddStopPresenter()
        
        pricePerGalloon.placeholder = "Price per Gallon"
        pricePerGalloon.title = "Price per Gallon"
        gallons.placeholder = "Gallons"
        gallons.title = "Gallons"
        cost.placeholder = "Cost"
        cost.title = "Cost"
        octane.placeholder = "Octane"
        octane.title = "Octane"
        tripOdometer.placeholder = "Trip Odometer"
        tripOdometer.title = "Trip Odometer"
        odometer.placeholder = "Odometer"
        odometer.title = "Odometer"
        
        dateFormatter.dateStyle = .medium

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
    
    func initialDataPopulation(location: CLLocation?) {
        self.stopLocation = location
        
        self.pricePerGalloon.text = ""
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
        
        if (pricePerGalloon.text?.isEmpty)! {
            isValid = false
            paintError(textField: pricePerGalloon)
        } else {
            paintClean(textField: pricePerGalloon)
        }

        if (gallons.text?.isEmpty)! {
            isValid = false
            paintError(textField: gallons)
        } else {
            paintClean(textField: gallons)
        }

        if (cost.text?.isEmpty)! {
            isValid = false
            paintError(textField: cost)
        } else {
            paintClean(textField: cost)
        }

        if (octane.text?.isEmpty)! {
            isValid = false
            paintError(textField: octane)
        } else {
            paintClean(textField: octane)
        }

        if (tripOdometer.text?.isEmpty)! {
            isValid = false
            paintError(textField: tripOdometer)
        } else {
            paintClean(textField: tripOdometer)
        }

        if (odometer.text?.isEmpty)! {
            isValid = false
            paintError(textField: odometer)
        } else {
            paintClean(textField: odometer)
        }
        
        return isValid
    }
    
    func gallonsData() -> Double {
        return Double(gallons.text!)!
    }

    func latitudeData() -> Double{
        return (stopLocation?.coordinate.latitude)!
    }

    func longitudeData() -> Double{
        return (stopLocation?.coordinate.longitude)!
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
        return Double(pricePerGalloon.text!)!
    }
    
    func stopDateData() -> Date{
        return Date()
    }
    
    func tripOdometerData() -> Double{
        return Double(tripOdometer.text!)!
    }
    
    private func paintError(textField: UITextField) {
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 2
    }
    
    private func paintClean(textField: UITextField) {
        textField.layer.masksToBounds = false
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
    }
}
