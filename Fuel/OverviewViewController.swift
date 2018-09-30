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
    
    private var presenter: OverviewContractPresenter?
    private var fuelStops = [FuelStop]()
    private var fuelStopAnnotations = [MKPointAnnotation]()
    
    private let fabSquareDim = CGFloat(50)
    private var fabX: CGFloat?
    private var fabY: CGFloat?
    
    let stopDetailPresentationManager = StopDetailPresentationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = OverviewPresenter()
        mapView.showsUserLocation = true
        
        self.addStopFABGestureRecognizer.numberOfTapsRequired = 1
        presenter?.loadFuelStops()
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
    
    func animateFABOffScreen() {
        if (fabX == nil) {
            fabX = self.addStopFAB.frame.origin.x
            fabY = self.addStopFAB.frame.origin.y
        }
        
        let x = self.addStopFAB.frame.origin.x
        let animator = UIViewPropertyAnimator(duration: 2, dampingRatio: 0.7) {
            let newY = self.view.bounds.height + CGFloat(2 * self.fabSquareDim);
            self.addStopFAB.frame = CGRect(x: x, y: CGFloat(newY), width: self.fabSquareDim, height: self.fabSquareDim)
        }
        animator.startAnimation()
    }

    func animateFABOnScreen(){
        let animator = UIViewPropertyAnimator(duration: 2, dampingRatio: 0.7) {
            self.addStopFAB.frame = CGRect(x: self.fabX!, y: self.fabY!, width: self.fabSquareDim, height: self.fabSquareDim)
        }
        animator.startAnimation()
    }
    
    // MARK: - OverviewContractView
    
    func addFuelStopToTable(fuelStop: FuelStop) {
        self.fuelStops.insert(fuelStop, at: 0)
        self.stopsTableView.reloadData()
        refreshMap()
    }
    
    func displayStops(fuelStops: [FuelStop]) {
        self.fuelStops.removeAll()
        self.fuelStops.append(contentsOf: fuelStops)
        self.stopsTableView.reloadData()
        refreshMap()
    }

    func refreshMap() {
        mapView.removeAnnotations(mapView.annotations)
        fuelStopAnnotations.removeAll()

        var mapRect = MKMapRectNull
        fuelStopAnnotations.append(contentsOf: fuelStops.map({(value: FuelStop) in
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(value.location.coordinate.latitude, value.location.coordinate.longitude)
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
    
    func zoomToUserLocation() {
        mapView.region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
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
        
        addStopViewController.transitioningDelegate = stopDetailPresentationManager
        addStopViewController.modalPresentationStyle = .custom
        
        present(addStopViewController, animated: true, completion: nil)
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Whoops", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuelStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopTableCell", for: indexPath) as! OverviewStopTableCell

        let stopData = fuelStops[indexPath.row]
        
        cell.stopDate.text = stopData.stopDate.longFormat()
        cell.gallonsFilled.text = stopData.gallons.gallonFormat()
        cell.totalPrice.text = stopData.price.currencyFormat()
        
        // Round Corners and Drop Shadow
        cell.stageView.layer.cornerRadius = 10
        cell.stageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.stageView.layer.shadowRadius = 0.5
        cell.stageView.layer.shadowOpacity = 0.2
        
        return cell
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.handleStopSelection(index: indexPath.row)
    }
    
    // MARK: - UIScrollViewDelegate

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animateFABOffScreen()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        animateFABOnScreen()
    }
    
}
