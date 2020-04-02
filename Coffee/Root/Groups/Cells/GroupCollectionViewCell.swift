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
    private var cancellables = Set<AnyCancellable>()

    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    lazy var titleBackground: UIVisualEffectView = {
        let v = UIVisualEffectView(effect: UIBlurEffect(style: .light))
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
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        contentView.addSubview(titleBackground)
        titleBackground.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        titleBackground.contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: titleBackground.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleBackground.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: titleBackground.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleBackground.trailingAnchor).isActive = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(coffeeGroup: CoffeeGroup) {
        
        titleLabel.text = coffeeGroup.name
        if let url = URL(string: coffeeGroup.imageUrl) {
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
