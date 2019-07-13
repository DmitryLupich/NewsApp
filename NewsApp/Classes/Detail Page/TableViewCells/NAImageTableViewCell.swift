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

    @IBOutlet weak var mainImageView: UIImageView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    // MARK: - Methods

    func fill(imageURL: String) {
        mainImageView.kf
            .setImage(with: URL(string: imageURL)!,
                      placeholder: UIImage(named: "placeholder"))
    }

    private func setupCell() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
    }
}
