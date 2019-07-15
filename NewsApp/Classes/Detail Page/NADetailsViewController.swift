//
//  NADetailsViewController.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/9/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit

final class NADetailsViewController: NABaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: DetailsViewModel
    private let tableView = UITableView()
    
    // MARK: - Initialization
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
}

// MARK: - Setup View

extension NADetailsViewController {
    private func setupView() {
        title = Constants.title
        view.addSubview(tableView)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(NATitleTableViewCell.self)
        tableView.register(NAImageTableViewCell.self)
    }
}

// MARK: - Bind ViewModel

extension NADetailsViewController {
    private func bindViewModel() {
        
        let input = DetailsViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.postComponents
            .bind(to: tableView.rx.items)
            { (tableView, row, element) in
                switch element {
                    
                case .title(let title),
                     .content(let title),
                     .date(let title):
                    let cell: NATitleTableViewCell = tableView
                        .dequeueReusableCell(forIndexPath: IndexPath(row: row, section: 0))
                    cell.fill(title: title)
                    return cell
                    
                case .image(let imageURL):
                    let cell: NAImageTableViewCell = tableView
                        .dequeueReusableCell(forIndexPath: IndexPath(row: row, section: 0))
                    cell.fill(imageURL: imageURL)
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
}

extension NADetailsViewController {
    struct Constants {
        static let title = "Details"
    }
}
