//
//  EventsViewController+UICollectionViewDelegate.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit

extension EventsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventCollectionViewCell,
            let groupEvent =  cell.groupEvent else {
            preconditionFailure("Could not deque GroupCollectionViewCell")
        }
        
        let venue = VenueViewController(groupEvent: groupEvent)
        present(venue, animated: true, completion: nil)
    }
}
