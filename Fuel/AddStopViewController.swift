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
    
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var pricePerGalloon: UITextField!
    @IBOutlet weak var gallons: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var octane: UITextField!
    @IBOutlet weak var tripOdometer: UITextField!
    @IBOutlet weak var odometer: UITextField!
    
    private var stopLocation: CLLocation?
    let dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = AddStopPresenter()
        
        dateFormatter.dateStyle = .medium
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
        date.inputView = datePicker

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
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        date.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func handleSaveTap(_ sender: Any) {
        presenter?.handleSaveTap()
    }
    @IBAction func handleCancelTap(_ sender: Any) {
        presenter?.handleCancelTap()
    }
    
    // MARK: AddStopContractView
    
    func initialDataPopulation(stopDate: Date, location: CLLocation?) {
        datePicker.date = stopDate
        date.text = dateFormatter.string(from: datePicker.date)
        
        stopLocation = location
        var locationText:String? = nil
        if let lat = location?.coordinate.latitude {
            if let lon = location?.coordinate.longitude {
                locationText = "\(lat), \(lon)"
            }
        }
        self.location.text = locationText
        
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
        
        if (date.text?.isEmpty)! {
            isValid = false
            paintError(textField: date)
        } else {
            paintClean(textField: date)
        }

        if (location.text?.isEmpty)! {
            isValid = false
            paintError(textField: location)
        } else {
            paintClean(textField: location)
        }

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
        return datePicker.date
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
