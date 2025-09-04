//
//  Logger.swift
//  YunoSwiftUI
//
//  Custom logger implementation for the project
//

import Foundation
import os.log

/// Custom logger for the Yuno SDK project
/// This logger provides different log levels and uses OSLog under the hood
final class Logger {
    
    private let osLog: OSLog
    private let category: String
    
    /// Initialize logger with a specific category
    /// - Parameter category: The category for this logger instance
    init(category: String) {
        self.category = category
        self.osLog = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.yuno.sdk", category: category)
    }
    
    /// Log debug information
    /// - Parameter message: The debug message to log
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        os_log("[DEBUG] %{public}s:%{public}d %{public}s - %{public}s", 
               log: osLog, type: .debug, fileName, line, function, message)
    }
    
    /// Log informational messages
    /// - Parameter message: The info message to log
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        os_log("[INFO] %{public}s:%{public}d %{public}s - %{public}s", 
               log: osLog, type: .info, fileName, line, function, message)
    }
    
    /// Log warning messages
    /// - Parameter message: The warning message to log
    func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        os_log("[WARNING] %{public}s:%{public}d %{public}s - %{public}s", 
               log: osLog, type: .default, fileName, line, function, message)
    }
    
    /// Log error messages
    /// - Parameter message: The error message to log
    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        os_log("[ERROR] %{public}s:%{public}d %{public}s - %{public}s", 
               log: osLog, type: .error, fileName, line, function, message)
    }
}

/// Global logger instance for the project
let logger = Logger(category: "YunoSDK")
