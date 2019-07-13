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

//class NAListTableViewCellViewModel: ViewModelType {
//
//    struct Input { }
//
//    struct Output {
//        let title: Observable<String>
//        let description: Observable<String>
//        let imageData: Observable<Data>
//    }
//
//    private let model: NewsModel
//
//    init(model: NewsModel) {
//        self.model = model
//    }
//
//    func transform(input: Input) -> Output {
//        let data = URLSession.shared
//            .rx
//            .data(request: URLRequest(url: URL(string: model.featuredMedia.fullSizeUrl)!))
//        return Output(title: Observable.just(model.titleRendered.title),
//                      description: Observable.just(model.),
//                      imageData: data)
//    }
//
//}

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
        descriptionLabel.text = model.date
        mainImageView.kf
            .setImage(with: URL(string: model.featuredMedia.fullSizeUrl)!,
                      placeholder: UIImage(named: "placeholder"))
    }
    
    private func setupCell() {
        mainImageView.layer.cornerRadius = mainImageView.frame.height/6
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
    }
}
