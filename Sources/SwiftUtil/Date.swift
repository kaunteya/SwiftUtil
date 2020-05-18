//
//  File.swift
//  
//
//  Created by Kaunteya Suryawanshi on 18/05/20.
//

import Foundation

public extension Date {
    /// Date().string(DateFormatter("d MMM yyyy")) -> 18 May 2020
    func string(_ formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }

    /// Date().string(format: "d MMM YYYY") -> 18 May 2020
    func string(format: String) -> String {
        string(DateFormatter(format))
    }
}

public extension DateFormatter {
    convenience init(_ format: String) {
        self.init()
        self.dateFormat = format
    }
}
