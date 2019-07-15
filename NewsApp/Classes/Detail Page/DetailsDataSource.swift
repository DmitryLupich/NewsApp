//
//  DetailsDataSource.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/15/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation
import UIKit.UITableView

class DetailsDataSource: NSObject {

    // MARK: - Private Properties

    private let dataSource: [PostComponents]
    private var numberOfRowsInSection: Int {
        return dataSource.count
    }

    // MARK: - Initialization

    init(dataSource: [PostComponents]) {
        self.dataSource = dataSource
    }
}

// MARK: - TableView DataSource

extension DetailsDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        Logger.log(value: indexPath)
        return createCell(type: dataSource[indexPath.row],
                          tableView: tableView,
                          indexPath: indexPath)
    }
}

// MARK: - Cell Factory

extension DetailsDataSource {
    func createCell(type: PostComponents,
                    tableView: UITableView,
                    indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .content(let title),
             .date(let title),
             .title(let title):
            let cell: NATitleTableViewCell = tableView
                .dequeueReusableCell(forIndexPath: indexPath)
            cell.fill(title: title)
            return cell
        case .image(let imageURL):
            let cell: NAImageTableViewCell = tableView
                .dequeueReusableCell(forIndexPath: indexPath)
            cell.fill(imageURL: imageURL)
            return cell
        }
    }
}
