//
//  NextViewController.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    lazy var activityView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .medium)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.hidesWhenStopped = true
        return v
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = NSLocalizedString("tab_next_drink_title", comment: "Next drink")
        tabBarItem.image = UIImage(systemName: "timer")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("tab_next_drink_title", comment: "Next drink")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

    }

}
