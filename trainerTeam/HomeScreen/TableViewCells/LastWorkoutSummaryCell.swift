//
//  LastWorkoutSummaryCell.swift
//  trainerTeam
//
//  Created by Connor Green on 4/12/20.
//  Copyright © 2020 Connor Green. All rights reserved.
//

import Foundation
import UIKit

class LastWorkoutSummaryCell: UITableViewCell {
    
    static let reuseIdentifier = "LastWorkoutSummaryCell"
    
    static var nib: UINib {
        return UINib(nibName: "LastWorkoutSummaryCell", bundle: .main)
    }
    
    static func newInstance() -> LastWorkoutSummaryCell {
        return nib.instantiate(withOwner: nil, options: nil).first as! LastWorkoutSummaryCell
    }
    
}
