//
//  DateHelperTests.swift
//  BlinkTest
//

import Foundation
import Testing
@testable import BlinkTest

final class DateHelperTests {
    @Test("Date is created correctly from input string")
    func dateFromString() {
        let result = DateHelper.date(from: "2020-05-04T03:37:18")
        
        let calendarDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: result!)
        #expect(calendarDate.year == 2020)
        #expect(calendarDate.month == 5)
        #expect(calendarDate.day == 4)
        #expect(calendarDate.hour == 3)
        #expect(calendarDate.minute == 37)
        #expect(calendarDate.second == 18)
    }
    
    @Test("Date string from date correctly formats a date to a string")
    func dateStringFromDate() {
        let date = DateHelper.date(from: "2020-05-04T03:37:18")!
        
        let result = DateHelper.dateString(from: date)
        
        #expect(result == "03:37 - 4 May 2020")
    }
}

