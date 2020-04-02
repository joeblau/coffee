//
//  EventsCollectionViewCell.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit
import Combine

class EventCollectionViewCell: UICollectionViewCell {

    public private(set) var groupEvent: GroupEvent?
    private var cancellables = Set<AnyCancellable>()
    
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        l.textColor = .secondaryLabel
        return l
    }()
    
    lazy var cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var cardImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var venueLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        l.textColor = .label
        l.numberOfLines = 0
        return l
    }()
    
    lazy var groupNameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        l.textColor = .secondaryLabel
        l.numberOfLines = 0
        return l
    }()
    
    lazy var eventRangeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .title3)
        l.textColor = .secondaryLabel
        return l
    }()
    
    lazy var cardContentView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [venueLabel, groupNameLabel, eventRangeLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = UIStackView.spacingUseSystem
        return v
    }()

    lazy var dateContentStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [dateLabel, cardView])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = UIStackView.spacingUseSystem
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dateContentStackView)
        
        cardView.addSubview(cardImageView)
        cardView.addSubview(cardContentView)

        NSLayoutConstraint.activate([
            dateContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            dateContentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateContentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            cardImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            cardImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5625),
            
            cardContentView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 16),
            cardContentView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            cardContentView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            cardContentView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with groupEvent: GroupEvent) {
        dateLabel.text = DateFormatter.monthDay.string(from: groupEvent.startAt)
        venueLabel.text = groupEvent.venue.name
        groupNameLabel.text = groupEvent.name
        
        do {
            let startTime = DateFormatter.hoursMinutes.string(from: groupEvent.startAt)
            let endTime = DateFormatter.hoursMinutes.string(from: groupEvent.endAt)
            eventRangeLabel.text = "\(startTime) — \(endTime)"
        }
        
        if let imageUrl = groupEvent.imageUrl,
            let url = URL(string: imageUrl.absoluteString) {
            URLSession.sharedSession
                .dataTaskPublisher(for: url)
                .sink(receiveCompletion: { error in
                    print(error)
                }) { (result: (data: Data, response: URLResponse)) in
                    DispatchQueue.main.async {
                        self.cardImageView.image = UIImage(data: result.data)
                    }
                }
                .store(in: &cancellables)
        }
    }

}
