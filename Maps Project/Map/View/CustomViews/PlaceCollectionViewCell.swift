//
//  PlaceCollectionViewCell.swift
//  Maps Project
//
//  Created by Danylo Klymov on 07.03.2022.
//

import UIKit

class PlaceCollectionViewCell: BaseDynamicHeightCollectionCell {
    
    //MARK: - Variables -
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addDropShadow(shadowOpacity: 0.5,
                           shadowRadius: 1,
                           shadowOffset: CGSize(width: -1, height: 1),
                           shadowColor: UIColor.black.cgColor)
        contentView.addSubview(view)
        return view
    }()
    private lazy var placeImageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(imageView)
        return imageView
    }()
    private var placeNameLabel: UILabel = {
        let placeNameLabel = UILabel()
        placeNameLabel.numberOfLines = 0
        placeNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeNameLabel
    }()
    private var placeVicinityLabel: UILabel = {
        let placeVicinityLabel = UILabel()
        placeVicinityLabel.numberOfLines = 0
        placeVicinityLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeVicinityLabel
    }()
    private var placeRatingLabel: UILabel = {
        let placeRatingLabel = UILabel()
        placeRatingLabel.textColor = .orange
        placeRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeRatingLabel
    }()
    
    private let horizontalSpacing: CGFloat = 10
    private let verticalSpacing: CGFloat = 10
    
    //MARK: - Life Cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUIElements()
    }
    
    //MARK: - Internal -
    func configure(with place: PlaceModel) {
        setPlaceImageIcon(place: place)
        setNameLabel(place: place)
        setRatingLabel(place: place)
        setVicinityLabel(place: place)
    }
    
    //MARK: - Private -
    private func setupUIElements() {
        layoutContainer()
        layoutImageView()
        layoutPlaceNameLabel()
        layoutPlaceVicinityLabel()
        layoutPlaceRatingLabel()
    }
    
    private func setPlaceImageIcon(place: PlaceModel) {
        placeImageIcon.setImage(with: place.iconURL)
    }
    
    private func layoutContainer() {
        containerView.pinEdges(to: self.contentView)
    }
    
    private func layoutImageView() {
        self.containerView.addSubview(placeImageIcon)
        let imageSize = CGSize(width: 110,
                               height: 110)
        
        NSLayoutConstraint.activate([
            placeImageIcon.widthAnchor.constraint(equalToConstant: imageSize.width),
            placeImageIcon.heightAnchor.constraint(equalToConstant: imageSize.height),
            placeImageIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            placeImageIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                    constant: horizontalSpacing)
        ])
    }
    
    private func setNameLabel(place: PlaceModel) {
        placeNameLabel.text = place.name ?? "Unknown place"
    }
    
    private func layoutPlaceNameLabel() {
        self.containerView.addSubview(placeNameLabel)
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                constant: verticalSpacing),
            placeNameLabel.leadingAnchor.constraint(equalTo: placeImageIcon.trailingAnchor,
                                                    constant: horizontalSpacing),
            placeNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                     constant: -horizontalSpacing)
        ])
    }
    
    private func setVicinityLabel(place: PlaceModel) {
        placeVicinityLabel.text = place.vicinity ?? "Location vicinity missing"
    }
    
    private func layoutPlaceVicinityLabel() {
        self.containerView.addSubview(placeVicinityLabel)
        NSLayoutConstraint.activate([
            placeVicinityLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor,
                                                    constant: verticalSpacing),
            placeVicinityLabel.leadingAnchor.constraint(equalTo: placeImageIcon.trailingAnchor,
                                                        constant: horizontalSpacing),
            placeVicinityLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                         constant: -horizontalSpacing)
        ])
    }
    
    private func setRatingLabel(place: PlaceModel) {
        guard let rating = place.rating else { return }
        placeRatingLabel.text = rating.stringValue
    }
    
    private func layoutPlaceRatingLabel() {
        self.containerView.addSubview(placeRatingLabel)
        
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
