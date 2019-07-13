//
//  Reusable.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable
{
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable where Self: UICollectionReusableView
{
    static var reuseIdentifier: String
    {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReuseIdentifiable {}

extension ReuseIdentifiable where Self: UITableViewCell
{
    static var reuseIdentifier: String
    {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable { }
