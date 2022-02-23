//
//  PlaceViewCell.swift
//  Maps Project
//
//  Created by Danylo Klymov on 21.02.2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell, CellRegistable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
}

class PlaceViewCell: BaseTableViewCell {
    
    //MARK: - Variables -
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.dropShadow()
        contentView.addSubview(view)
        return view
    }()
    private lazy var placeImageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        self.containerView.addSubview(imageView)
        return imageView
    }()
    private var placeNameLabel: UILabel = {
        let placeNameLabel = UILabel()
        placeNameLabel.numberOfLines = 0
        placeNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        placeNameLabel.text = "Unknown place"
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeNameLabel
    }()
    private var placeVicinityLabel: UILabel = {
        let placeVicinityLabel = UILabel()
        placeVicinityLabel.numberOfLines = 0
        placeVicinityLabel.text = "Location vicinity missing"
        placeVicinityLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeVicinityLabel
    }()
    private var placeRatingLabel: UILabel = {
        let placeRatingLabel = UILabel()
        placeRatingLabel.numberOfLines = 1
        placeRatingLabel.textColor = .orange
        placeRatingLabel.text = ""
        placeRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeRatingLabel
    }()
    
    private var place: PlaceModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUIElements()
    }
    
    //MARK: - Internal -
    func configure(with place: PlaceModel) {
        self.place = place
        setPlaceImageIcon()
        setNameLabel()
        setRatingLabel()
        setVicinityLabel()
//        setupUIElements()
    }
    
    //MARK: - Private -
    private func setupUIElements() {
        layoutContainer()
        layoutImageView()
        layoutPlaceNameLabel()
        layoutPlaceVicinityLabel()
        layoutPlaceRatingLabel()
    }
    
    private func setPlaceImageIcon() {
        guard let place = place else {
            placeImageIcon.setImage(withURL: nil)
            return
        }
        placeImageIcon.setImage(withURL: place.icon)
    }
    
    private func layoutContainer() {
        containerView.pinEdges(to: self.contentView)
    }
    
    private func layoutImageView() {
        setPlaceImageIcon()
        self.containerView.addSubview(placeImageIcon)
        let imageSize = CGSize(width: 110,
                               height: 110)
        NSLayoutConstraint.activate([
            placeImageIcon.widthAnchor.constraint(equalToConstant: imageSize.width),
            placeImageIcon.heightAnchor.constraint(equalToConstant: imageSize.height),
            placeImageIcon.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                constant: 20),
            placeImageIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                    constant: 20)
        ])
    }
    
    private func setNameLabel() {
        guard let place = place else { return }
        placeNameLabel.text = place.name ?? "Unknown place"
    }
    
    private func layoutPlaceNameLabel() {
        setNameLabel()
        self.containerView.addSubview(placeNameLabel)
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                constant: 20),
            placeNameLabel.leadingAnchor.constraint(equalTo: placeImageIcon.trailingAnchor,
                                                    constant: 10),
            placeNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                     constant: -10)
        ])
    }
    
    private func setVicinityLabel() {
        placeVicinityLabel.text = place?.vicinity ?? "Location vicinity missing"
    }
    
    private func layoutPlaceVicinityLabel() {
        setVicinityLabel()
        self.containerView.addSubview(placeVicinityLabel)
        NSLayoutConstraint.activate([
            placeVicinityLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor,
                                                    constant: 10),
            placeVicinityLabel.leadingAnchor.constraint(equalTo: placeImageIcon.trailingAnchor,
                                                        constant: 10),
            placeVicinityLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                         constant: -10)
        ])
    }
    
    private func setRatingLabel() {
        guard let place = place else { return }
        guard let rating = place.rating else { return }
        placeRatingLabel.text = String(rating)
    }
    
    private func layoutPlaceRatingLabel() {
        setRatingLabel()
        self.containerView.addSubview(placeRatingLabel)
        let horizontalSpacing: CGFloat = 10
        let verticalSpacing: CGFloat = 10

        NSLayoutConstraint.activate([
            placeRatingLabel.topAnchor.constraint(equalTo: placeVicinityLabel.bottomAnchor,
                                                  constant: verticalSpacing),
            placeRatingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                       constant: -horizontalSpacing),
            placeRatingLabel.leadingAnchor.constraint(equalTo: placeImageIcon.trailingAnchor,
                                                      constant: horizontalSpacing),
            placeRatingLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                   constant: -verticalSpacing)
        ])
    }
    
}
