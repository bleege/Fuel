//
//  OverviewContract.swift
//  Fuel
//
//  Created by Brad Leege on 12/23/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//


protocol OverviewContractView {
    func displayStops(fuelStops: [FuelStopsMO])
    func refreshMap()
}

protocol OverviewContractPresenter {
        func loadFuelStops()
}
