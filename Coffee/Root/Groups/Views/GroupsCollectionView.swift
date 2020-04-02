//
//  GroupsCollectionView.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

class GroupsCollectionView: UICollectionView {
    var diffableDataSource: GroupsDiffableDataSource?
    
    init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        diffableDataSource = GroupsDiffableDataSource(collectionView: self)
        dataSource = diffableDataSource
        backgroundColor = .systemBackground
        register(GroupCollectionViewCell.self,
                 forCellWithReuseIdentifier: GroupCollectionViewCell.id)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
