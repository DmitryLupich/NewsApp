//
//  NAListTableViewCell.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

final class NAListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Methods
    
    func fill(_ model: NewsModel) {
        titleLabel.text = model.titleRendered.title
        descriptionLabel.text = model.contentRendered.content
        _ = model.featuredMedia?.fullSizeUrl
            .flatMap(URL.init)
            .map { mainImageView.kf
            .setImage(with: $0,
                      placeholder: UIImage.placeholder)
        }
    }
    
    private func setupCell() {
        mainImageView.layer.cornerRadius = mainImageView.frame.height/6
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
    }
}
