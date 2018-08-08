//
//  weatherTableViewCell.swift
//  WeatherApp
//
//  Created by Andrew Lofthouse on 07/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import Foundation
import UIKit

class weatherTableViewCell : UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
}
