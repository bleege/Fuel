//
//  OverviewViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit
import MapKit

class OverviewViewController: UIViewController, OverviewContractView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stopsTableView: UITableView!
    @IBOutlet weak var addStopFAB: FABView!
    @IBOutlet var addStopFABGestureRecognizer: UITapGestureRecognizer!
    
    var presenter: OverviewContractPresenter?
    var fuelStops = [FuelStopsMO]()
    var fuelStopAnnotations = [MKPointAnnotation]()
    
    let stopDetailPresentationManager = StopDetailPresentationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = OverviewPresenter()
        mapView.showsUserLocation = true
        
        self.addStopFABGestureRecognizer.numberOfTapsRequired = 1
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
    
    @IBAction func handleFABTap(_ sender: UITapGestureRecognizer) {
        presenter?.handleAddStopFABTap()
    }
    
    // MARK: OverviewContractView
    
    func displayStops(fuelStops: [FuelStopsMO]) {
        self.fuelStops.removeAll()
        self.fuelStops.append(contentsOf: fuelStops)
        self.stopsTableView.reloadData()
        refreshMap()
    }

    func refreshMap() {
        mapView.removeAnnotations(mapView.annotations)
        fuelStopAnnotations.removeAll()

        var mapRect = MKMapRectNull
        fuelStopAnnotations.append(contentsOf: fuelStops.map({(value: FuelStopsMO) in
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(value.latitude, value.longitude)
            mapView.addAnnotation(pin)
            let annPoint = MKMapPointForCoordinate(pin.coordinate)
            let pointRect = MKMapRectMake(annPoint.x, annPoint.y, 0.0, 0.0)
            if (MKMapRectIsNull(mapRect)) {
                mapRect = pointRect
            } else {
                mapRect = MKMapRectUnion(mapRect, pointRect)
            }
            return pin
        }))
        if (!MKMapRectIsNull(mapRect)) {
            let padding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            mapView.setVisibleMapRect(mapRect, edgePadding: padding, animated: false)
        }
    }
    
    func displayStopOnMap(index: Int) {
        let ann = fuelStopAnnotations[index]
        mapView.region = MKCoordinateRegionMakeWithDistance(ann.coordinate, 1000, 1000)
        mapView.selectAnnotation(ann, animated: true)
    }
    
    func displayStopDataView(index: Int) {
        print("display stop data view for index = \(index)")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let stopDetailViewController = sb.instantiateViewController(withIdentifier: "stopDetailViewControllerId") as! StopDetailViewController

        stopDetailViewController.stopData = fuelStops[index]
        stopDetailViewController.transitioningDelegate = stopDetailPresentationManager
        stopDetailViewController.modalPresentationStyle = .custom
        
        present(stopDetailViewController, animated: true, completion: nil)
    }
    
    func displayAddStopViewController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let addStopViewController = sb.instantiateViewController(withIdentifier: "addStopViewControllerId") as! AddStopViewController
        
        present(addStopViewController, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuelStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopTableCell", for: indexPath) as! OverviewStopTableCell

        let stopData = fuelStops[indexPath.row]
        
        cell.stopDate.text = stopData.stop_date!.shortFormat()
        cell.gallonsFilled.text = stopData.gallons.gallonFormat()
        cell.totalPrice.text = stopData.price.currencyFormat()
        
        return cell
    }

    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.handleStopSelection(index: indexPath.row)
    }
}
