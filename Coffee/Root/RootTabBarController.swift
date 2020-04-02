//
//  ViewController.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [UINavigationController(rootViewController: GroupsViewController())]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

