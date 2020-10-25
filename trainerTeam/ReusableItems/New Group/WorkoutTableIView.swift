//
//  workoutTableIView.swift
//  trainerTeam
//
//  Created by Connor Green on 5/28/20.
//  Copyright © 2020 Connor Green. All rights reserved.
//

import Foundation
import UIKit

class WorkoutTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var workoutTable = UITableView()
    var workout: Workout?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workout?.workouts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
