//
//  OverviewViewController.swift
//  Fuel
//
//  Created by Brad Leege on 11/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit
import MapKit
import os.log

class OverviewViewController: UIViewController, OverviewContractView, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var stopsTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.systemGray6
        table.separatorStyle = .none
        table.register(OverviewStopTableCell.self, forCellReuseIdentifier: "stopTableCell")
        return table
    }()
    
    private let addStopFAB: FABView = {
        let fab = FABView()
        fab.translatesAutoresizingMaskIntoConstraints = false
        return fab
    }()
    
    private lazy var addStopFABGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleFABTap))
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var presenter: OverviewContractPresenter?
    private var fuelStops = [FuelStop]()
    private var fuelStopAnnotations = [MKPointAnnotation]()
    
    private let fabSquareDim = CGFloat(50)
    private var fabX: CGFloat?
    private var fabY: CGFloat?
    
    let stopDetailPresentationManager = StopDetailPresentationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load View Hierarchy
        stack.addArrangedSubview(mapView)
        stack.addArrangedSubview(stopsTableView)
        view.addSubview(stack)
        
        addStopFAB.addGestureRecognizer(addStopFABGestureRecognizer)
        view.addSubview(addStopFAB)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addStopFAB.heightAnchor.constraint(equalToConstant: 50.0),
            addStopFAB.widthAnchor.constraint(equalToConstant: 50.0),
            addStopFAB.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addStopFAB.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40.0)
        ])
        
        // Do any additional setup after loading the view, typically from a nib.
        presenter = (UIApplication.shared.delegate as? AppDelegate)?.container?.resolve(OverviewContractPresenter.self)
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
        
    @objc
    func handleFABTap(_ sender: UITapGestureRecognizer) {
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
            mapView.setVisibleMapRect(mapRect, edgePadding: padding, animated: true)
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
        os_log(.info, log: Log.general, "display stop data view for index = %d", index)
        let stopDetailViewController = StopDetailViewController()
        
        stopDetailViewController.stopData = fuelStops[index]
        stopDetailViewController.transitioningDelegate = stopDetailPresentationManager
        stopDetailViewController.modalPresentationStyle = .custom
        
        present(stopDetailViewController, animated: true, completion: nil)
    }
    
    func displayAddStopViewController() {
        let addStopViewController = AddStopViewController()
        
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
    
    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        
        if (pin == nil) {
            pin = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        pin?.displayPriority = .required
        
        return pin
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let selectedAnnotation = view.annotation {
            if selectedAnnotation is MKUserLocation {
                return
            }
            let index = fuelStopAnnotations.firstIndex(of: selectedAnnotation as! MKPointAnnotation)
            presenter?.handleStopSelection(index: index!)
        }
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuelStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopTableCell", for: indexPath) as! OverviewStopTableCell

        let stopData = fuelStops[indexPath.row]
        
        cell.stopDate.text = stopData.stopDate.longFormat()
        cell.gallonsFilled.text = stopData.gallons.gallonFormat()
        cell.totalPrice.text = stopData.price.currencyFormat()
                
        return cell
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
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
