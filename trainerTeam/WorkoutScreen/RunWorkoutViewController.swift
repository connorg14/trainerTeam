//
//  RunWorkoutViewController.swift
//  trainerTeam
//
//  Created by Connor Green on 4/25/20.
//  Copyright © 2020 Connor Green. All rights reserved.
//


import Foundation
import UIKit

class RunWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    @IBOutlet weak var workoutView: UIView!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var workoutTableView: UITableView!
    @IBOutlet weak var ActivityLabel: UILabel!
    

    var countdownTimer = Timer()
    var totalTime = 20
    var currentWorkout: Workout!
    var numberOfWorkouts: Int = 0
    var itemCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        timerButton.layer.cornerRadius = 8
        numberOfWorkouts = currentWorkout.workouts.count
        // Do any additional setup after loading the view, typically from a nib.
    }
    deinit {
        // ViewController going away.  Kill the timer.
        countdownTimer.invalidate()
    }
    
    // MARK: - Timing Methods

    func runCountdown(_ time: Int) {
        totalTime = time
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.totalTime -= 1
            if self?.totalTime == 0 {
                timer.invalidate()
            } else if let seconds = self?.totalTime {
                self?.timerButton.setTitle("\(seconds)", for: .normal)
            }
        }
    }

    @IBAction func touchedStart(_ sender: Any) {
        startWorkout()
    }
    
    // MARK: - Run the workout
    
    func endWorkout() {
        ActivityLabel.text = "DONE"
        timerButton.setTitle("DONE", for: .normal)
    }
    
    func runTimer() {
        let seconds = currentWorkout.workouts[itemCount].seconds
        ActivityLabel.text = currentWorkout.workouts[itemCount].title
        runCountdown(seconds)
        itemCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
            if self.itemCount < self.numberOfWorkouts {
                self.runTimer()
            }
        }
    }
    
    func startWorkout() {
        let introTime = 3
        ActivityLabel.text = "GET READY"
        runCountdown(introTime)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(introTime)) {
            self.runTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.currentWorkout.getTotalTime())) {
                self.endWorkout()
            }
        }
    }
}
