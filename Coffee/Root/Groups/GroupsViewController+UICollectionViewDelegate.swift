//
//  GroupsViewController+UICollectionViewDelegate.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

extension GroupsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GroupCollectionViewCell,
            let coffeeGroup =  cell.coffeeGroup else {
            preconditionFailure("Could not deque GroupCollectionViewCell")
        }
        let event = EventsViewController(coffeeGroup: coffeeGroup)
        navigationController?.pushViewController(event, animated: true)
    }
}
