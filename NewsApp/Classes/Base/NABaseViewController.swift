//
//  NABaseViewController.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit

class NABaseViewController: UIViewController {

    // MARK: - Deinit
    
    deinit {
        #if DEBUG
        Logger.log(message: "Deinitialization",
                   value: String(describing: self),
                   logType: .info)
        #endif
    }
}
