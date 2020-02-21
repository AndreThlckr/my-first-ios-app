//
//  AppTabController.swift
//  De Bar em Bar
//
//  Created by Jonathan on 21/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

class AppTabController: UITabBarController, TabController {
    
    override var selectedIndex: Int {
        didSet{
            print("Switching to index \(selectedIndex)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let tabs = viewControllers else { return }
        for aVC in tabs {
            if let aTab = aVC as? ATabController {
                aTab.tabDelegate = self
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let child = segue.destination as? ATabController {
            child.tabDelegate = self
        }
    }
    
    func switchTab(to: Tab) {
        let index = to.rawValue
        guard let viewControllerCount = viewControllers?.count, index >= 0 && index < viewControllerCount else {return}
        selectedIndex = index
    }

}
