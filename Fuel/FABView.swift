//
//  FABView.swift
//  Fuel
//
//  Created by Brad Leege on 1/25/18.
//  Copyright © 2018 Brad Leege. All rights reserved.
//

import UIKit

class FABView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        self.isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Circle
        UIColor.green.setFill()
        let circle = UIBezierPath(ovalIn: rect)
        circle.fill()
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.white.cgColor)
            context.setLineWidth(2)
            
            // Horizontal
            context.move(to: CGPoint(x: bounds.width / 4, y: bounds.height / 2))
            context.addLine(to: CGPoint(x: bounds.width * 0.75, y: bounds.height / 2))
            
            // Vertical
            context.move(to: CGPoint(x: bounds.width / 2, y: bounds.height / 4))
            context.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height * 0.75))
            
            context.strokePath()
        }
    }

}
