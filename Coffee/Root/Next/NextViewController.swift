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
    
    lazy var emptyDataView: EmptyDataView = {
        EmptyDataView(title: NSLocalizedString("next_event_unavailable", comment: "No upcoming events"))
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = NSLocalizedString("tab_near_me_title", comment: "Next drink")
        tabBarItem.image = UIImage(systemName: "mappin.circle.fill")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("tab_near_me_title", comment: "Near me")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(emptyDataView)
        
        NSLayoutConstraint.activate([
            emptyDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyDataView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emptyDataView.startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emptyDataView.stopAnimation()
    }

}
