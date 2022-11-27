//
//  Extensions+String.swift
//  presentation
//
//  Created by Nihad Ismayilov on 18.09.22.
//

import Foundation

extension String {
    func localize() -> String {
        let localizationManager = LocalizationManager.shared
        let text = localizationManager.localizedStringForKey(key: self)
        return text
    }
}

extension String {
    func getFormattedDateDayMonthYear () -> String {
        let splitDate = self.split(separator: "-")
        print("CountNum \(splitDate.count)")
        if splitDate.count == 3{
            return splitDate[2] + "." + splitDate[1] + "." + splitDate[0]
        }else{
            return "-"
        }
    }
    
    func getFormattedDateDayMonthYearHour () -> String {
        let splitDateAndTime = self.split(separator: " ")
        let splitDate = splitDateAndTime[0].split(separator: "-")
        print("CountNum \(splitDate.count)")
        if splitDate.count == 3{
            return splitDate[2] + "." + splitDate[1] + "." + splitDate[0] + " " + splitDateAndTime[1]
        }else{
            return ""
        }
    }
    
    var toDateS: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from:self)
    }
    
    var toDateM: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-SS:SS"
        return dateFormatter.date(from:self)
    }
    
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from:self)
    }
    
    var toDateL: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+SSSS"
        return dateFormatter.date(from:self)
    }
}

extension Date {
    var toString: String {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        let dString = df.string(from: self)
        return dString
    }
    
    var toServerString: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dString = df.string(from: self)
        return dString
    }
    
    var toServerStrings: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dString = df.string(from: self)
        return dString
    }
    
    var toStringWithTime: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let dString = df.string(from: self)
        return dString
    }
}
