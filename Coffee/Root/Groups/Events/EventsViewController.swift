//
//  EventsViewController.swift
//  Coffee
//
//  Created by Joe Blau on 4/1/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit
import Combine

final class EventsViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let coffeeGroup: CoffeeGroup
    
    private lazy var eventsCollectionView: EventsCollectionView = {
        let v = EventsCollectionView()
        v.delegate = self
        return v
    }()
    
    init(coffeeGroup: CoffeeGroup) {
        self.coffeeGroup = coffeeGroup
        super.init(nibName: nil, bundle: nil)
        title = coffeeGroup.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(eventsCollectionView)
        NSLayoutConstraint.activate([
            eventsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            eventsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            eventsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Current.coffeeAPI
            .events(for: coffeeGroup.id)
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }) { groupEvents in
                
                let events = groupEvents.compactMap { groupEvent -> EventValue? in
                    EventValue(event: groupEvent)
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<EventSection, EventValue>()
                snapshot.appendSections([.events])
                snapshot.appendItems(events, toSection: .events)
                self.eventsCollectionView.diffableDataSource?.apply(snapshot)
            }
            .store(in: &cancellables)
    }
    
}
