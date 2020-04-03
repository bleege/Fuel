//
//  Log.swift
//  Fuel
//
//  Created by Brad Leege on 3/30/20.
//  Copyright © 2020 Brad Leege. All rights reserved.
//

import Foundation
import os.log

struct Log {
    static let general = OSLog(subsystem: "io.leege.fuel", category: "general")
}
