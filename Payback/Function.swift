//
//  Function.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI

class Formatter {
    static func getFormattedDate(date: Date, format: String = "dd.MM") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }

    static func getFormattedNumber(number: Double, digitsCount: Int = 2) -> String {
        if Double(Int(number)) == number {
            return String(Int(number))
        } else {
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = digitsCount
            numberFormatter.minimumFractionDigits = digitsCount
            numberFormatter.locale = Locale(identifier: "ru_RU")
            guard let s = numberFormatter.string(from: NSNumber(value: number)) else {
                return String(number)
            }
            return s
        }
    }
}
