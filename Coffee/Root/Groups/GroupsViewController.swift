//
//  GroupsViewController.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit
import Combine

final class GroupsViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()

    lazy var groupsCollectionView: GroupsCollectionView = {
        let v = GroupsCollectionView()
        v.delegate = self
        return v
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = NSLocalizedString("tab_groups_title", comment: "Coffee groups")
        tabBarItem.image = UIImage(systemName: "person.3")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("tab_groups_title", comment: "Coffee groups")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(groupsCollectionView)
        
        NSLayoutConstraint.activate([
            groupsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            groupsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            groupsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            groupsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        Current.coffeeAPI
            .groups
            .sink(receiveCompletion: { error in
                print(error)
            }) { coffeeGroups in
                let groups = coffeeGroups.compactMap { coffeeGroup -> GroupValue? in
                    GroupValue(group: coffeeGroup)
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<GroupSection, GroupValue>()
                snapshot.appendSections([.groups])
                snapshot.appendItems(groups, toSection: .groups)
                self.groupsCollectionView.diffableDataSource.apply(snapshot)
        }
        .store(in: &cancellables)
    }
}
