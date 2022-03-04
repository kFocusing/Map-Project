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
    
    //MARK: - Life Cycle-
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: - Internal -
    func configure(with place: PlaceModel) {
        setIconImage(icon: place.icon)
        setNameLabel(name: place.name)
        setRatingLabel(rating: place.rating)
        setVicinityLabel(vicinity: place.vicinity)
    }
    
    //MARK: - Private -
    private func setIconImage(icon: String?) {
        iconImage.setImage(with: icon)
    }
    
    private func setNameLabel(name: String?) {
        nameLabel.text = name ?? "Unknown place"
    }
    
    
    private func setVicinityLabel(vicinity: String?) {
        vicinityLabel.text = vicinity ?? "Location vicinity missing"
    }
    
    private func setRatingLabel(rating: Double?) {
        guard let rating = rating else { return }
        ratingLabel.text = String(rating)
        
    }
}
