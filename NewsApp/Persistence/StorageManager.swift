//
//  StorageManager.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/11/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

protocol Persistable {
    func write<T: Encodable>(models: [T])
    func read<T: Decodable>(modelType: T.Type) -> [T]
}

final class StorageManager {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let fileName = "Storage.txt"
    private let fileManager = FileManager.default
    private let documentsDirectoryPathString =
        NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                            .userDomainMask, true).first ?? ""
    private var jsonFilePath: URL {
        return documentsDirectoryPath.appendingPathComponent(fileName)
    }
    private var documentsDirectoryPath: URL {
        return URL(string: documentsDirectoryPathString)!
    }
}

extension StorageManager: Persistable {
    
    func write<T>(models: [T]) where T : Encodable {
        checkFileExistance()
        do {
            let modelData = try self.encoder.encode(models.self)
            let file = try FileHandle(forWritingTo: self.jsonFilePath)
            file.write(modelData)
            Logger.log(message: "Writing Successful", value: "", logType: .info)
        } catch {
            Logger.log(message: "Writing Error", value: error, logType: .error)
        }
    }
    
    func read<T>(modelType: T.Type) -> [T] where T : Decodable {
        do {
            let strURL = documentsDirectoryPathString.appending("/").appending(fileName)
            let url = URL.init(fileURLWithPath: strURL)
            let data = try Data(contentsOf: url)
            let models: [T] = try decoder.decode([T].self, from: data)
            Logger.log(message: "Read models count", value: models.count, logType: .info)
            return models
        } catch
        {
            Logger.log(message: "Reading Error", value: error, logType: .error)
            return []
        }
    }
}

extension StorageManager {
    private func checkFileExistance() {
        if !fileManager.fileExists(atPath: jsonFilePath.absoluteString) {
            let _ = fileManager.createFile(atPath: jsonFilePath.absoluteString,
                                           contents: nil,
                                           attributes: nil)
        }
    }
}
