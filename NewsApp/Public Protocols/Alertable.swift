//
//  Alertable.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit.UIViewController

fileprivate struct Constants {
    static let title = "Warning"
    static let okTitle = "Ok"
    static let alertStyle = UIAlertController.Style.alert
    static let alertActionStyle = UIAlertAction.Style.default
}

protocol Alertable {
    func alert(message: String)
}

extension Alertable where Self: NABaseViewController {
    func alert(message: String) {
        let alert = UIAlertController(title: Constants.title,
                                      message: message,
                                      preferredStyle: Constants.alertStyle)
        let okayAction = UIAlertAction(title: Constants.okTitle,
                                       style: Constants.alertActionStyle,
                                       handler: nil)
        alert.addAction(okayAction)
        present(alert, animated: true)
    }
}

extension NABaseViewController: Alertable { }
