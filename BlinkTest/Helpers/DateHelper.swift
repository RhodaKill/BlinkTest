//
//  DateHelper.swift
//  BlinkTest
//

import Foundation

struct DateHelper {
    static func date(from dateString: String = "2020-05-04T03:37:18") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: dateString)
    }
    
    static func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm - d MMM y"
        return formatter.string(from: date)
    }
}
