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
    private var dataSource: DetailsDataSource?
    
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
        bindViewModel()
        setupView()
        tableView.reloadData()
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
        tableView.dataSource = dataSource
    }
}

// MARK: - Bind ViewModel

extension NADetailsViewController {
    private func bindViewModel() {
        dataSource = DetailsDataSource(dataSource: viewModel.postComponentes)
    }
}

// MARK: - Constants

extension NADetailsViewController {
    struct Constants {
        static let title = "Details"
    }
}
