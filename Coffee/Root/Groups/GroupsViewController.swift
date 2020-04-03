// GroupsViewController.swift
// Copyright (c) 2020 Joe Blau

import Combine
import UIKit

final class GroupsViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()

    lazy var groupsCollectionView: GroupsCollectionView = {
        let v = GroupsCollectionView()
        v.delegate = self
        return v
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: NSLocalizedString("tab_groups_title", comment: "Coffee groups"),
                                  image: UIImage(systemName: "person.3"),
                                  selectedImage: UIImage(systemName: "person.3.fill"))
    }

    required init?(coder _: NSCoder) {
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
