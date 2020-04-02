//
//  GroupsDiffableDataSource.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

class GroupsDiffableDataSource: UICollectionViewDiffableDataSource<GroupSection, GroupValue> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, groupValue) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.id,
                                                                for: indexPath) as? GroupCollectionViewCell else { return nil }
            cell.configure(with: groupValue.group)
            return cell
        }
    }
}
