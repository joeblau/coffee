// GroupsViewController+UICollectionViewDelegate.swift
// Copyright (c) 2020 Joe Blau

import UIKit

extension GroupsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GroupCollectionViewCell,
            let coffeeGroup = cell.coffeeGroup else {
            preconditionFailure("Could not deque GroupCollectionViewCell")
        }
        let event = EventsViewController(coffeeGroup: coffeeGroup)
        navigationController?.pushViewController(event, animated: true)
    }
}
