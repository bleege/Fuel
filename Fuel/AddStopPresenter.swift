//
//  AddStopPresenter.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//


class AddStopPresenter: AddStopContractPresenter {

    private var view:AddStopContractView?
    
    func onAttach(view: AddStopContractView) {
        self.view = view
    }

    func onDetach() {
        self.view = nil
    }
 
    func handleCancelTap() {
        view?.dismiss()
    }
}
