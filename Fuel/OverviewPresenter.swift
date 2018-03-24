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
    
    private var view: OverviewContractView?
    
    private let dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    
    private let disposeBag = DisposeBag()
    
    init() {
        // No Op
    }
    
    // MARK: OverviewContractPresenter
    
    func onAttach(view: OverviewContractView) {
        self.view = view
    }
    
    func onDetach() {
        self.view = nil
    }
    
    func loadFuelStops() {
        dataManager.getAllFuelStops().toArray()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (element) in
                print("Number of Elements Returned = \(element.count)")
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
        self.view?.displayStopOnMap(index: index)
        self.view?.displayStopDataView(index: index)
    }
 
    func handleAddStopFABTap() {
        view?.displayAddStopViewController()
    }

}
