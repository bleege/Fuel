//
//  SecondViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import CoreLocation
import UIKit
import RxSwift

class AddStopViewController: UIViewController, AddStopContractView {

    var presenter: AddStopContractPresenter?
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var pricePerGallonTextField: UITextField!
    @IBOutlet weak var gallonsTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var octaneTextField: UITextField!
    @IBOutlet weak var tripOdometerTextField: UITextField!
    @IBOutlet weak var tripMPGTextField: UITextField!
    @IBOutlet weak var odometerTextField: UITextField!
    
    private var pricePerGallon: Double = 0
    private var gallons: Double = 0
    private var cost: Double = 0
    private var octane: Int = 0
    private var tripOdometer: Double = 0
    private var odometer: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = AddStopPresenter()
                
        // Dismiss Keyboard Input
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        pricePerGallonTextField.rx.value.filter { str in !(str ?? "").isEmpty } .subscribe({event in
            self.pricePerGallon = Double(self.stripDollarSign(string: event.element!!))!
            self.updatePriceTextField()
        }).disposed(by: disposeBag)
        gallonsTextField.rx.value.filter { str in !(str ?? "").isEmpty } .subscribe({event in
            self.gallons = Double(event.element!!)!
            self.updatePriceTextField()
            self.updateTripMPGTextField()
        }).disposed(by: disposeBag)
        tripOdometerTextField.rx.value.filter { str in !(str ?? "").isEmpty } .subscribe({event in
            self.tripOdometer = Double(event.element!!)!
            self.updateTripMPGTextField()
        }).disposed(by: disposeBag)
        
        pricePerGallonTextField.rx.controlEvent(UIControlEvents.editingDidEnd)
            .subscribe({event in self.updatePricePerGallonTextField() })
            .disposed(by: disposeBag)
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
        return Double(gallonsTextField.text!)!
    }
    
    func octaneData() -> Int{
        return Int(octaneTextField.text!)!
    }
    
    func odometerData() -> Int{
        return Int(odometerTextField.text!)!
    }
    
    func priceData() -> Double{
        return Double(costTextField.text!)!
    }
    
    func ppgData() -> Double{
        return Double(pricePerGallonTextField.text!)!
    }
    
    func stopDateData() -> Date{
        return Date()
    }
    
    func tripOdometerData() -> Double{
        return Double(tripOdometerTextField.text!)!
    }
    
    func stripDollarSign(string: String) -> String {
        return string.replacingOccurrences(of: "$", with: "")
    }
    
    private func updatePricePerGallonTextField() {
        pricePerGallonTextField.text = pricePerGallon.currencyFormat()
    }
    
    private func updatePriceTextField() {
        cost = pricePerGallon * gallons
        costTextField.text = cost.currencyFormat()
    }
    
    private func updateTripMPGTextField() {
        if (gallons == 0) {
            tripMPGTextField.text = 0.mpgFormat()
        } else {
            tripMPGTextField.text = (tripOdometer / gallons).mpgFormat()
        }
    }
}
