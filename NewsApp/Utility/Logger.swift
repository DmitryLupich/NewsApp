//
//  Logger.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

enum LogType: String
{
    case error = "⛔️ Error: "
    case token = "🔑 Token: "
    case info  = "💎 Info: "
}

struct Logger
{
    static func log(message: String = "", value: Any, logType: LogType = .info)
    {
        let text: String = logType.rawValue + message + " \(value)"
        consoleLog(text)
    }
    
    private static func consoleLog(_ message: String)
    {
        let consoleLog = spacing + message + spacing
        print(consoleLog)
    }
    
    private static let spacing = "\n---------------------------------\n"
}
