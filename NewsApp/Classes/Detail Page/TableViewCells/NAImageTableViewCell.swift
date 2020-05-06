//
//  NAImageTableViewCell.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/9/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit
import Kingfisher

final class NAImageTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var mainImageView: UIImageView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    // MARK: - Methods

    func fill(imageURL: String?) {
        _ = imageURL
            .flatMap(URL.init)
            .map {
                mainImageView.kf.setImage(with: $0,placeholder: UIImage.placeholder)
        }
    }

    private func setupCell() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
    }
}
