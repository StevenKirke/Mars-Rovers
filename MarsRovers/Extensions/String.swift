//
//  String.swift
//  MarsRovers
//
//  Created by Steven Kirke on 13.04.2023.
//

import SwiftUI


extension String {
    func convertDate() -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
          .withFractionalSeconds,
          .withFullDate
        ]
        let date = inputFormatter.date(from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        guard let date = date else {
            return self
        }
        return dateFormatter.string(from: date)
    }
}
