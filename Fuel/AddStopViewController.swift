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
        presenter = (UIApplication.shared.delegate as? AppDelegate)?.container?.resolve(AddStopContractPresenter.self)

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
    
    // MARK: - AddStopContractView
    
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
        
        if (pricePerGallonTextField.text?.isEmpty)! {
            isValid = false
            paintError(textField: pricePerGallonTextField)
        } else {
            paintClean(textField: pricePerGallonTextField)
        }

        if (gallonsTextField.text?.isEmpty)! {
            isValid = false
            paintError(textField: gallonsTextField)
        } else {
            paintClean(textField: gallonsTextField)
        }

        if (costTextField.text?.isEmpty)! {
            isValid = false
            paintError(textField: costTextField)
        } else {
            paintClean(textField: costTextField)
        }

        if (octaneTextField.text?.isEmpty)! {
            isValid = false
            paintError(textField: octaneTextField)
        } else {
            paintClean(textField: octaneTextField)
        }

        if (tripOdometerTextField.text?.isEmpty)! {
            isValid = false
            paintError(textField: tripOdometerTextField)
        } else {
            paintClean(textField: tripOdometerTextField)
        }

        if (odometerTextField.text?.isEmpty)! {
            isValid = false
            paintError(textField: odometerTextField)
        } else {
            paintClean(textField: odometerTextField)
        }
        
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
        return Double(stripDollarSign(string: costTextField.text!))!
    }
    
    func ppgData() -> Double{
        return Double(stripDollarSign(string: pricePerGallonTextField.text!))!
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
