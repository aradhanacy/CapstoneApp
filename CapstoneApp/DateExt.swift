//
//  Date+Ext.swift
//  CapstoneApp
//
//  Created by 64001315 on 3/29/24.
//
import SwiftData
import Foundation

extension Date {
    
    var isWeekday: Bool {
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: self)
            return (2...6).contains(weekday) // Monday to Friday
        }
    
    func isSameDay(as date: Date) -> Bool {
            let calendar = Calendar.current
            return calendar.isDate(self, equalTo: date, toGranularity: .day)
        }
    
    
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    // returns date as march 2024
    func monthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    //returns date as 03/04/2024
    func monthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    // returns date as march 4, 2024
    func fullMonthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        return formatter.string(from: self)
    }
    
    // returns date as monday, tuesday, etc.
    func dayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    // returns date as 5:53 PM
    func timeFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    func bookingViewDateFormat() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let start = timeFormatter.string(from: self)
        
        let endDate = Calendar.current.date(byAdding: .minute, value: 30, to: self)!
        let end = timeFormatter.string(from: endDate)
        let day = self.dayOfTheWeek()
        let fullDateString = self.fullMonthDayYearFormat()
        
        return "\(start) - \(end), \(day), \(fullDateString)"
    }
    
}
