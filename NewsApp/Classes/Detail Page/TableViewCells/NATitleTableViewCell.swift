//
//  NATitleTableViewCell.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/9/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit

final class NATitleTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Methods

    func fill(title: String) {
        titleLabel.text = title.replacingOccurrences(of: "<[^>]+>", with: "",
                                                     options: .regularExpression,
                                                     range: nil)
    }
}
