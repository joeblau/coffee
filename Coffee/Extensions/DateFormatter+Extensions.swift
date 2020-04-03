// DateFormatter+Extensions.swift
// Copyright (c) 2020 Joe Blau

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
        f.dateFormat = "HH:mm a"
        return f
    }()

    static let relativeShort: RelativeDateTimeFormatter = {
        let f = RelativeDateTimeFormatter()
        f.unitsStyle = .short
        return f
    }()
}
