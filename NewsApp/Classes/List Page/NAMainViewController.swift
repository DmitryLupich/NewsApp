//
//  NAMainViewController.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit

final class NAMainViewController: NABaseViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let viewModel: MainViewModel
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Initialization
    
    init(viewModel: MainViewModel) {
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
        viewModel.start()
    }
}

// MARK: - Setup View

extension NAMainViewController {
    private func setupView() {
        title = Constants.title
        view.addSubview(tableView)
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.register(NAListTableViewCell.self)
        tableView.rowHeight = Constants.rowHeigh
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let _ = [tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                 tableView.topAnchor.constraint(equalTo: view.topAnchor),
                 tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                 tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].map { $0.isActive = true }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NAMainViewController {
    @objc private func refresh(_ sender: UIRefreshControl) {
        viewModel.start()
    }
}

// MARK: - Bind ViewModel

extension NAMainViewController {
    private func bindViewModel() {
        viewModel.render = { [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.render(state: state)
        }
    }
}

// MARK: - Methods

extension NAMainViewController {
    private func render(state: MainViewModel.ListModel) {
        switch state {
        case .data:
            self.showData()
        case .isLoading(let isLoading):
            self.handleRefresh(isLoading)
        case .error(let error):
            self.showError(error)
        }
    }
    
    private func showData() {
        tableView.reloadData()
    }
    
    private func handleRefresh(_ isLoading: Bool) {
        if !isLoading { refreshControl.endRefreshing() }
    }
    
    private func showError(_ error: Error) {
        alert(message: error.localizedDescription)
    }
}

// MARK: - TableView Delegate

extension NAMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selected(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.rowChanged(indexPath.row)
    }
}

// MARK: - TableView DataSource

extension NAMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NAListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.fill(viewModel.publicDataSource[indexPath.row])
        return cell
    }
}

// MARK: - Constants

extension NAMainViewController {
    struct Constants {
        static let title = "News"
        static let rowHeigh: CGFloat = 100.0
    }
}
