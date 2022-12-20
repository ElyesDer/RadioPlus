//
//  Date+.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

extension Date {
    
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM yyyy HH:mm:ss Z"
        return formatter.string(from: self)
    }
    
    init(posixTime: Int32) {
        self.init(timeIntervalSince1970: Double(posixTime))
    }
    
    init(dateString: String, dateFormat: String = "dd.MM.yyyy") {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = dateFormat
        if let date = dateStringFormatter.date(from: dateString) {
            self.init(timeInterval: 0, since: date)
        } else {
            self.init(timeInterval: 0, since: Date())
        }
    }
    
    func posixTime() -> Int32 {
        return Int32(timeIntervalSince1970)
    }
    
    func stringFromDateWithDateFormat(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    static func combineDateTime(_ date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        
        let dateComponents = (calendar as NSCalendar).components([.year, .month, .day], from: date)
        let timeComponents = (calendar as NSCalendar).components([.hour, .minute], from: time)
        
        var combineDateComponents = DateComponents()
        combineDateComponents.year = dateComponents.year
        combineDateComponents.month = dateComponents.month
        combineDateComponents.day = dateComponents.day
        combineDateComponents.hour = timeComponents.hour
        combineDateComponents.minute = timeComponents.minute
        
        if let combineDate = calendar.date(from: combineDateComponents) {
            return combineDate
        }
        
        return nil
    }
    
    func yesterdayDate() -> Date? {
        let calendar = Calendar.current
        return (calendar as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: [])
    }
    
}
