//
//  StopDetailViewController.swift
//  Fuel
//
//  Created by Brad Leege on 1/15/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//


import UIKit

class StopDetailViewController: UIViewController {
    
    @IBOutlet weak var stopDateLabel: UILabel!
    @IBOutlet weak var ppgLabel: UILabel!
    @IBOutlet weak var gallonsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var tripOdometerLabel: UILabel!
    @IBOutlet weak var tripMPGLabel: UILabel!
    @IBOutlet weak var odometerLabel: UILabel!
    @IBOutlet weak var octaneLabel: UILabel!
    
    var stopData: FuelStopsMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        stopDateLabel.text = stopData?.stop_date?.shortFormat()
        ppgLabel.text = stopData?.price_per_gallon.currencyFormat()
        gallonsLabel.text = stopData?.gallons.gallonFormat()
        costLabel.text = stopData?.price.currencyFormat()
        tripOdometerLabel.text = stopData?.trip_odometer.tripOdometerFormat()
        tripMPGLabel.text = stopData?.mpg.mpgFormat()
        if let odometer = stopData?.odometer {
            odometerLabel.text = String(odometer)
        }
        if let octane = stopData?.octane {
            octaneLabel.text = String(octane)
        }
        
        setupTapToDismissRecognizer()
    }
    
    private func setupTapToDismissRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}
