//
//  Date+Extension.swift
//  MeuApt
//
//  Created by mac mini capgemini sp on 14/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//

import Foundation
import Marshal

extension Date : ValueType{
    public static func from(isoDate: String)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: isoDate)
        return date
    }
    var toString : String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: self)
    }
    public static func value(from object: Any) throws -> Date {
        guard let dateString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }
        // assuming you have a Date.fromISO8601String implemented...
        guard let date = Date.from(isoDate: dateString) else {
            throw MarshalError.typeMismatch(expected: "ISO8601 date string", actual: dateString)
        }
        return date
    }
}
