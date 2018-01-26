//
//  FABView.swift
//  Fuel
//
//  Created by Brad Leege on 1/25/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import UIKit

class FABView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.green.setFill()
        let circle = UIBezierPath(ovalIn: rect)
        circle.fill()
    }

}
