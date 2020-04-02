//
//  DateFormatter+Extensions.swift
//  Coffee
//
//  Created by Joe Blau on 4/2/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import Foundation

extension DateFormatter {
      static let iso8601Full: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        f.calendar = Calendar(identifier: .iso8601)
        f.timeZone = TimeZone(secondsFromGMT: 0)
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
      }()
    
    static let monthDay: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }()
    
    static let hoursMinutes: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()
}
