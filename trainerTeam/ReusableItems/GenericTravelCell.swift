//
//  GoToWorkoutCell.swift
//  trainerTeam
//
//  Created by Connor Green on 4/12/20.
//  Copyright © 2020 Connor Green. All rights reserved.
//

import Foundation
import UIKit

class GenericTravelCell: UITableViewCell {
    
    static let reuseIdentifier = "GenericTravelCell"
    
    static var nib: UINib {
        return UINib(nibName: "GenericTravelCell", bundle: .main)
    }
    
    static func newInstance() -> GenericTravelCell {
        return nib.instantiate(withOwner: nil, options: nil).first as! GenericTravelCell
    }
}
