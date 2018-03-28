//
//  Extensions.swift
//  Fuel
//
//  Created by Brad Leege on 1/23/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import Foundation

extension Date {

    func shortFormat() -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
        return df.string(from: self)
    }
    
    func longFormat() -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return df.string(from: self)
    }

}

extension Double {
    
    func currencyFormat() -> String {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_US")
        nf.numberStyle = .currency
        return nf.string(from: self as NSNumber)!
    }
    
    func gallonFormat() -> String {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_US")
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 4
        nf.maximumFractionDigits = 4
        return nf.string(from: self as NSNumber)!
    }
    
    func mpgFormat() -> String {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_US")
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 3
        nf.maximumFractionDigits = 3

        return nf.string(from: self as NSNumber)!
    }
    
    func tripOdometerFormat() -> String {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_US")
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 1
        nf.maximumFractionDigits = 1

        return nf.string(from: self as NSNumber)!
    }

}
