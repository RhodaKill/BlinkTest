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
}
