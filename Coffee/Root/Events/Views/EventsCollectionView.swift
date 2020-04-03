// EventsCollectionView.swift
// Copyright (c) 2020 Joe Blau

import UIKit

final class EventsCollectionView: UICollectionView {
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<EventSection, EventValue> = {
        UICollectionViewDiffableDataSource(collectionView: self) { collectionView, indexPath, eventValue in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.id,
                                                                for: indexPath) as? EventCollectionViewCell else { return nil }
            cell.configure(with: eventValue.event)
            return cell
        }
    }()

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
        dataSource = diffableDataSource
        backgroundColor = .systemBackground
        register(EventCollectionViewCell.self,
                 forCellWithReuseIdentifier: EventCollectionViewCell.id)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
