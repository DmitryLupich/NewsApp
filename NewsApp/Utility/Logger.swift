//
//  Logger.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

enum LogType: String {
    case info  = "💎 Info: "
    case error = "⛔️ Error: "
    case unexpected = "💩 Shit happens: "
}

struct Logger {
    static func log(message: String = "", value: Any, logType: LogType = .info) {
        #if DEBUG
        let text: String = logType.rawValue + message + " \(value)"
        consoleLog(text)
        #endif
    }
    
    private static func consoleLog(_ message: String) {
        let consoleLog = spacing + message + spacing
        print(consoleLog)
    }
    private static let spacing = "\n---------------------------------\n"
}
