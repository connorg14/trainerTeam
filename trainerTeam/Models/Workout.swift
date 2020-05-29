//
//  Workout.swift
//  trainerTeam
//
//  Created by Connor Green on 4/11/20.
//  Copyright © 2020 Connor Green. All rights reserved.
//

import Foundation

class Workout {
    var workouts: [WorkoutSet] = []
    var title: String = "Workout"
    var restSeconds: Int = 5
    var workSeconds: Int = 10
    
    func addWorkOut(title:String, description: String) {
        workouts.append(WorkoutSet(numberOfReps: 10, title: title, description: description, seconds: workSeconds))
        workouts.append(WorkoutSet(numberOfReps: 10, title: "Rest", description: "Rest", seconds: restSeconds))
    }
    
    func getTotalTime() -> Int {
        return workouts.map({$0.seconds}).reduce(0, +)
    }
}
