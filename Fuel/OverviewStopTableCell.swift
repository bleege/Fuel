//
//  OverviewStopTableCell.swift
//  Fuel
//
//  Created by Brad Leege on 12/21/17.
//  Copyright © 2017 Brad Leege. All rights reserved.
//

import UIKit

class OverviewStopTableCell: UITableViewCell {
    
    @IBOutlet weak var stageView: UIView!
    @IBOutlet weak var stopDate: UILabel!
    @IBOutlet weak var gallonsFilled: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Round Corners and Drop Shadow
        self.stageView.layer.cornerRadius = 10
        self.stageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.stageView.layer.shadowRadius = 0.5
        self.stageView.layer.shadowOpacity = 0.2
    }
    
}
