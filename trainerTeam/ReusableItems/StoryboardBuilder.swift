//
//  StoryboardBuilder.swift
//  trainerTeam
//
//  Created by Connor Green on 4/25/20.
//  Copyright © 2020 Connor Green. All rights reserved.
//

import UIKit

public struct StoryboardBuilder {
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - Public methods
    
    public func buildViewController<T: UIViewController>(storyboardName: String,
                                                         storyboardID: String? = nil,
                                                         bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboardName,
                                      bundle: bundle)
        
        if let storyboardID = storyboardID {
            guard let result = storyboard.instantiateViewController(withIdentifier: storyboardID) as? T else {
                preconditionFailure("The expected view controller type does not match what was returned from the storyboard")
            }
            
            return result
        } else {
            guard let result = storyboard.instantiateInitialViewController() as? T else {
                preconditionFailure("The expected view controller type does not match what was returned from the storyboard")
            }
            
            return result
        }
    }
}
