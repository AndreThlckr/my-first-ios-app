//
//  ATabController.swift
//  De Bar em Bar
//
//  Created by Jonathan on 21/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

@objc enum Tab: Int {
    case first = 0
    case second
    case third
}

@objc protocol TabController {
    @objc func switchTab(to: Tab)
}

class ATabController: UIViewController {

    weak var tabDelegate: TabController?
}
