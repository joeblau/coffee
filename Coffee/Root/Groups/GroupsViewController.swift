//
//  GroupsViewController.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit
import Combine

class GroupsViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    lazy var groupsCollectionView: GroupsCollectionView = { GroupsCollectionView() }()
    let groupsController = CoffeeAPIController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = NSLocalizedString("tab_groups_title", comment: "Coffee groups")
        tabBarItem.image = UIImage(systemName: "person.3.fill")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("tab_groups_title", comment: "Coffee groups")
        view.backgroundColor = .systemBackground
        
        view.addSubview(groupsCollectionView)
        groupsCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        groupsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        groupsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        groupsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        groupsController.groups()
            .sink(receiveCompletion: { error in
                print(error)
            }) { coffeeGroups in
                let items = coffeeGroups.compactMap { coffeeGroup -> GroupValue? in
                    GroupValue(group: coffeeGroup)
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<GroupSection, GroupValue>()
                snapshot.appendSections([.groups])
                snapshot.appendItems(items, toSection: .groups)
                self.groupsCollectionView.diffableDataSource?.apply(snapshot)
        }
        .store(in: &cancellables)
    }
    
}
