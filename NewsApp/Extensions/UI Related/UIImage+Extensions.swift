//
//  UIImage+Extensions.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/13/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
    // MARK: - For using "placeholder" Image
    static var placeholder: UIImage {
        return UIImage(named: #function) ?? UIImage()
    }
}
