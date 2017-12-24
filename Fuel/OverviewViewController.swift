//
//  OverviewViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class OverviewViewController: UIViewController, OverviewContractView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!

    var presenter: OverviewPresenter?
    var fuelStops = [FuelStopsMO]()
    let dateFormatter = DateFormatter()
    let gallonFormatter = NumberFormatter()
    let priceFormatter = NumberFormatter()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = OverviewPresenter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
        gallonFormatter.locale = Locale(identifier: "en_US")
        gallonFormatter.minimumSignificantDigits = 4
        priceFormatter.locale = Locale(identifier: "en_US")
        priceFormatter.numberStyle = .currency
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
    
    // MARK: OverviewContractView
    
    func displayStops(fuelStops: [FuelStopsMO]) {
        self.fuelStops.removeAll()
        self.fuelStops.append(contentsOf: fuelStops)
        refreshMap()
    }

    func refreshMap() {
        mapView.removeAnnotations(mapView.annotations)
        
        fuelStops.map({(value: FuelStopsMO) in
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(value.latitude, value.longitude)
            mapView.addAnnotation(pin)
        })
    }
    
    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuelStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopTableCell", for: indexPath) as! OverviewStopTableCell

        let stopData = fuelStops[indexPath.row]
        
        // TODO - Fix data loading of stop date from Core Data
        cell.stopDate.text = dateFormatter.string(from: stopData.stop_date!)
        cell.gallonsFilled.text = gallonFormatter.string(from: stopData.gallons as NSNumber)
        cell.totalPrice.text = priceFormatter.string(from: stopData.price as NSNumber)
        
        return cell
    }

}
