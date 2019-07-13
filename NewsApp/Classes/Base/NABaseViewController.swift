//
//  NABaseViewController.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NABaseViewController: UIViewController {
    
    // MARK: - Properties
    
    internal let disposeBag = DisposeBag()
    internal let didLoad = ReplaySubject<Void>.create(bufferSize: 1)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad.onNext(())
    }
    
    deinit {
        #if DEBUG
        Logger.log(message: "Deinitialization",
                   value: String(describing: self),
                   logType: .info)
        #endif
    }
}
