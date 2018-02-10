//
//  AddStopContract.swift
//  Fuel
//
//  Created by Brad Leege on 2/9/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//


protocol AddStopContractView {
    func dismiss()
}


protocol AddStopContractPresenter {
    func onAttach(view: AddStopContractView)
    func onDetach()
    func handleCancelTap()
}
