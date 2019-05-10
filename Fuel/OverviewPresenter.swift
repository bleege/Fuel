//
//  OverviewPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 12/20/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class OverviewPresenter: OverviewContractPresenter {
    
    private weak var view: OverviewContractView?
    
    private var dataManager: FuelStopsDataManagerContract
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    }
    
    init(dataManager: FuelStopsDataManagerContract) {
        self.dataManager = dataManager
    }
    
    // MARK: - OverviewContractPresenter
    
    func onAttach(view: OverviewContractView) {
        self.view = view
    }
    
    func onDetach() {
        self.view = nil
    }
    
    func loadFuelStops() {
        dataManager.getAllFuelStops()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { (element) in
                var stops = [FuelStop]()
                for ckr in element {
                    stops.append(FuelStop(record: ckr))
                }
                self.view?.displayStops(fuelStops: stops)
            }, onError: { (error) in
                print("Error = \(error)")
                self.view?.displayError(message: "Error getting fuel stops.")
            }).disposed(by: disposeBag)
    }
    
    func handleStopSelection(index: Int) {
        view?.displayStopOnMap(index: index)
        view?.displayStopDataView(index: index)
    }
 
    func handleAddStopFABTap() {
        view?.zoomToUserLocation()
        view?.displayAddStopViewController()
    }
}
