// EmptyDataView.swift
// Copyright (c) 2020 Joe Blau

import UIKit

final class EmptyDataView: UIView {
    var emojiXConstriant: NSLayoutConstraint?
    var shadowWidthConstraint: NSLayoutConstraint?
    var shadowHeightConstraint: NSLayoutConstraint?

    private lazy var emoji: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "☕️"
        l.textAlignment = .center
        l.backgroundColor = .clear
        l.font = UIFont.systemFont(ofSize: 60)
        return l
    }()

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textAlignment = .center
        l.textColor = .label
        return l
    }()

    private lazy var shadow: UIImageView = {
        let image = UIImage(systemName: "circle.fill")
        let v = UIImageView(image: image)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tintColor = .secondarySystemBackground
        return v
    }()

    init(title _: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString("next_event_unavailable", comment: "No upcoming events")

        addSubview(emoji)
        addSubview(shadow)
        addSubview(titleLabel)

        emojiXConstriant = emoji.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50)
        shadowWidthConstraint = shadow.widthAnchor.constraint(equalToConstant: 60.0)
        shadowHeightConstraint = shadow.heightAnchor.constraint(equalToConstant: 24.0)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 300),
            heightAnchor.constraint(equalToConstant: 300),
            emoji.centerXAnchor.constraint(equalTo: centerXAnchor),

            emojiXConstriant!,
            emoji.heightAnchor.constraint(greaterThanOrEqualToConstant: 10.0),
            emoji.widthAnchor.constraint(greaterThanOrEqualToConstant: 10.0),

            shadow.centerXAnchor.constraint(equalTo: centerXAnchor),
            shadow.centerYAnchor.constraint(equalTo: centerYAnchor),
            shadowWidthConstraint!,
            shadowHeightConstraint!,

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10.0),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }

    func startAnimation() {
        DispatchQueue.main.async {
            self.emojiXConstriant?.constant = -60
            self.shadowWidthConstraint?.constant = 50
            self.shadowHeightConstraint?.constant = 20

            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: [.autoreverse, .repeat],
                           animations: {
                               self.layoutIfNeeded()
            }, completion: nil)
        }
    }

    func stopAnimation() {
        emoji.layer.removeAllAnimations()
        shadow.layer.removeAllAnimations()

        emojiXConstriant?.constant = -50.0
        shadowWidthConstraint?.constant = 60.0
        shadowHeightConstraint?.constant = 24.0
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
