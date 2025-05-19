//
//  dates.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

extension DateFormatter {
    static func standardDate() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .gmt
        return dateFormatter
    }
    
    static func standardDateTime() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = .gmt
        return dateFormatter
    }
    
    static func displayDate() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
    
    static func displayTime() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
}
