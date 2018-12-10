//
//  MovieCell.swift
//  MovieOMDB
//
//  Created by irna on 12/10/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    func configure(_ model: Search) {
        titleLabel.text = model.title
        yearLabel.text = model.year
        
        
        guard let posterPath = model.poster else { return }
        let imgUrl = URL(string: posterPath)
        posterImageView.kf.setImage(with: imgUrl)
    }
    
}
