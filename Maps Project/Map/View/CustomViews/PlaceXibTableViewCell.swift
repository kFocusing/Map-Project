//
//  PlaceXibTableViewCell.swift
//  Maps Project
//
//  Created by Danylo Klymov on 03.03.2022.
//

import UIKit

class PlaceXibTableViewCell: BaseTableViewCell {
    
    //MARK: - IBOutlet -
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var vicinityLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    //MARK: - Internal -
    func configure(with place: PlaceModel) {
        setIconImage(place: place)
        setNameLabel(place: place)
        setRatingLabel(place: place)
        setVicinityLabel(place: place)
    }
    
    //MARK: - Private -
    private func setIconImage(place: PlaceModel) {
        iconImage.setImage(with: place.icon)
    }
    
    private func setNameLabel(place: PlaceModel) {
        nameLabel.text = place.name ?? "Unknown place"
    }
    
    private func setVicinityLabel(place: PlaceModel) {
        vicinityLabel.text = place.vicinity ?? "Location vicinity missing"
    }
    
    private func setRatingLabel(place: PlaceModel) {
        guard let rating = place.rating else { return }
        ratingLabel.text = String(rating)
    }
}
