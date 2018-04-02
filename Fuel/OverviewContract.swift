//
//  OverviewContract.swift
//  Fuel
//
//  Created by Brad Leege on 12/23/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//


protocol OverviewContractView {
    func addFuelStopToTable(fuelStop: FuelStop)
    func displayStops(fuelStops: [FuelStop])
    func refreshMap()
    func zoomToUserLocation()
    func displayStopOnMap(index: Int)
    func displayStopDataView(index: Int)
    func displayAddStopViewController()
    func displayError(message: String)
}

protocol OverviewContractPresenter {
    func onAttach(view: OverviewContractView)
    func onDetach()
    func loadFuelStops()
    func handleStopSelection(index: Int)
    func handleAddStopFABTap();
}
