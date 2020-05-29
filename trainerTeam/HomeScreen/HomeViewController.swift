//
//  FirstViewController.swift
//  trainerTeam
//
//  Created by Connor Green on 4/11/20.
//  Copyright © 2020 Connor Green. All rights reserved.
//

import UIKit

enum homeViewCellType {
    case lastWorkout
    case selectWorkout
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var workouts: [Workout] = []
    var homeViewDateSource: [homeViewCellType] = [.lastWorkout, .selectWorkout]
    
    var storyboardBuilder = StoryboardBuilder()
    //let navigationController = UINavigationController(rootViewController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        workouts.append(createStubWorkout())
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch homeViewDateSource[indexPath.row] {
        case .lastWorkout:
            return dequeueLastWorkoutCell(indexPath: indexPath)
        case .selectWorkout:
            return dequeueGenericTravelCell(indexPath: indexPath)
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch homeViewDateSource[indexPath.row] {
        case .lastWorkout:
            return 180
        case .selectWorkout:
            return 60
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch homeViewDateSource[indexPath.row] {
        case .lastWorkout:
            return
        case .selectWorkout:
            pushWorkoutViewController()
        default:
            return
        }
    }
    
    private func dequeueGenericTravelCell(indexPath: IndexPath) -> GenericTravelCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenericTravelCell.reuseIdentifier,
                                                 for: indexPath) as! GenericTravelCell
        return cell
    }
    
    private func dequeueLastWorkoutCell(indexPath: IndexPath) -> LastWorkoutSummaryCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LastWorkoutSummaryCell.reuseIdentifier,
                                                 for: indexPath) as! LastWorkoutSummaryCell
        return cell
    }
    
 
    // MARK: - Private Functions
    
    private func pushWorkoutViewController() {
        let viewController: RunWorkoutViewController = storyboardBuilder.buildViewController(storyboardName: "RunWorkoutViewController", storyboardID: "RunWorkoutViewController", bundle: nil)
        viewController.currentWorkout = createStubWorkout()
        self.present(viewController, animated: false, completion: nil)
    }
    
    private func createStubWorkout() -> Workout {
        let workout = Workout()
        workout.addWorkOut(title: "Pushups", description: "push")
        workout.addWorkOut(title: "Squats", description: "legs")
        return workout
    }
    
    private func setupDataSourceDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableView() {
        setupDataSourceDelegate()
        tableView.register(UINib(nibName: "GenericTravelCell", bundle: nil), forCellReuseIdentifier: "GenericTravelCell")
        tableView.register(UINib(nibName: "LastWorkoutSummaryCell", bundle: nil), forCellReuseIdentifier: "LastWorkoutSummaryCell")
    }
}

