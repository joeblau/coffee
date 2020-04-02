//
//  GroupCollectionViewCell.swift
//  Coffee
//
//  Created by Joe Blau on 3/31/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import UIKit
import Combine
class GroupCollectionViewCell: UICollectionViewCell {
    public private(set) var coffeeGroup: CoffeeGroup?
    private var cancellables = Set<AnyCancellable>()

    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    lazy var titleBackground: UIVisualEffectView = {
        let v = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleBackground)
        titleBackground.contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            titleBackground.heightAnchor.constraint(equalToConstant: 48),
            titleBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleBackground.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleBackground.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleBackground.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleBackground.trailingAnchor),
        ])

    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coffeeGroup: CoffeeGroup) {
        self.coffeeGroup = coffeeGroup
        titleLabel.text = coffeeGroup.name
        if let url = URL(string: coffeeGroup.imageUrl.absoluteString) {
            URLSession.sharedSession
                .dataTaskPublisher(for: url)
                .sink(receiveCompletion: { error in
                    print(error)
                }) { (result: (data: Data, response: URLResponse)) in
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: result.data)
                    }
                }
                .store(in: &cancellables)
        }
    }
}
