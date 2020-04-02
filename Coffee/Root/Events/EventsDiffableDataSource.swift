//
//  EventsDiffableDataSource.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

class EventsDiffableDataSource: UICollectionViewDiffableDataSource<EventSection, EventValue> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, eventValue) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.id,
                                                                for: indexPath) as? EventCollectionViewCell else { return nil }
            cell.configure(with: eventValue.event)
            return cell
        }
    }
}
