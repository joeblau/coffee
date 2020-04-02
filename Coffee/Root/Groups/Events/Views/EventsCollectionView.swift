//
//  EventsCollectionView.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

class EventsCollectionView: UICollectionView {
        var diffableDataSource: EventsDiffableDataSource?
        
        init() {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(300.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(300.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])

            let section = NSCollectionLayoutSection(group: group)            
            let layout = UICollectionViewCompositionalLayout(section: section)

            super.init(frame: .zero, collectionViewLayout: layout)
            translatesAutoresizingMaskIntoConstraints = false
            diffableDataSource = EventsDiffableDataSource(collectionView: self)
            dataSource = dataSource
            backgroundColor = .systemBackground
            register(EventCollectionViewCell.self,
                     forCellWithReuseIdentifier: EventCollectionViewCell.id)
        }

        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
    
}
