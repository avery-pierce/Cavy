//
//  DateParser.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/18/21.
//

import Foundation

let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}()

func parseLemmyDate(_ dateString: String) -> Date? {
    formatter.date(from: dateString)
}

func abbreviatedTimeInterval(of timeInterval: TimeInterval) -> String {
    if timeInterval < 1 {
        return "now"
    } else if timeInterval < 60 {
        return "\(Int(round(timeInterval)))s"
    } else if timeInterval < (60 /* seconds */ * 60 /* minutes */) {
        let minutes = timeInterval / 60.0
        return "\(Int(round(minutes)))m"
    } else if timeInterval < (60 /* seconds */ * 60 /* minutes */ * 24 /* hours */) {
        let minutes = timeInterval / 60.0
        let hours = minutes / 60.0
        return "\(Int(round(hours)))h"
    } else {
        let minutes = timeInterval / 60.0
        let hours = minutes / 60.0
        let days = hours / 24.0
        return "\(Int(round(days)))d"
    }
}
