// EventsViewController+UICollectionViewDelegate.swift
// Copyright (c) 2020 Joe Blau

import UIKit

extension EventsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventCollectionViewCell,
            let groupEvent = cell.groupEvent else {
            preconditionFailure("Could not deque GroupCollectionViewCell")
        }

        let venue = VenueViewController(groupEvent: groupEvent)
        present(venue, animated: true, completion: nil)
    }
}
