//
//  StorageManager.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/11/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

fileprivate struct Constants {
    static let fileName: String = "Storage.txt"
}

protocol Persistable {
    func write<T: Encodable>(models: [T])
    func read<T: Decodable>(modelType: T.Type) -> [T]
}

final class StorageManager {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let fileName = Constants.fileName
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

    private var fileUrl: URL {
        return URL.init(fileURLWithPath: documentsDirectoryPathString
            .appending("/")
            .appending(fileName))
    }
}

extension StorageManager: Persistable {
    
    func write<T>(models: [T]) where T : Encodable {
        DispatchQueue.global(qos: .userInteractive).async {
            self.clearCache()
            self.save(models: models)
        }
    }
    
    func read<T>(modelType: T.Type) -> [T] where T : Decodable {
        return get()
    }
}

extension StorageManager {
    private func clearCache() {
        do {
            try fileManager.removeItem(at: fileUrl)
        } catch {
            Logger.log(message: "Delete file", value: error, logType: .error)
        }
        fileManager.createFile(atPath: jsonFilePath.absoluteString,
                               contents: nil,
                               attributes: nil)
    }

    private func save<T>(models: [T]) where T : Encodable {
        do {
            let modelData = try self.encoder.encode(models.self)
            let file = try FileHandle(forWritingTo: self.jsonFilePath)
            file.write(modelData)
            Logger.log(message: "Writing Successful", value: "", logType: .info)
        } catch {
            Logger.log(message: "Writing Error", value: error, logType: .error)
        }
    }

    private func get<T>() -> [T] where T: Decodable {
        do {
            let data = try Data(contentsOf: fileUrl)
            let models: [T] = try decoder.decode([T].self, from: data)
            Logger.log(message: "Read models count", value: models.count, logType: .info)
            return models
        } catch
        {
            Logger.log(message: "Reading Error", value: error, logType: .unexpected)
            return []
        }
    }
}
