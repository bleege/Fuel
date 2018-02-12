//
//  AddStopPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import CoreLocation
import Foundation

class AddStopPresenter: AddStopContractPresenter {

    private var view:AddStopContractView?
    
    func onAttach(view: AddStopContractView) {
        self.view = view
        self.view?.initialDataPopulation(stopDate: Date(), location: CLLocation(latitude: 44, longitude: -89))
    }

    func onDetach() {
        self.view = nil
    }
 
    func handleCancelTap() {
        view?.dismiss()
    }
}
