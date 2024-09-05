//
//  String+Addition.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation

extension String {
    /// Function to convert date format
    func formattedDate(
        output format: String = "MMM dd, yyyy, h:mm:ss a",
        inputDateFormate: String = "yyyy-MM-dd'T'HH:mm:ss.SS"
    ) -> String {
        /// Define the input date formatter
        let inputFormatter = DateFormatter.formatter(with: inputDateFormate)

        /// Convert the input string to a Date object
        guard let date = inputFormatter.date(from: self) else { return "" }

        /// Define the output date formatter
        let outputFormatter = DateFormatter.formatter(with: format)

        /// Convert the Date object to the desired output format
        let outputDate = outputFormatter.string(from: date)
        return outputDate
    }

    func timeAgoString() -> String {
        /// Define the input date formatter
        let inputFormatter = DateFormatter.iso8601WithFractionalSecondsFormatter

        /// Convert the input string to a Date object
        guard let dateTime = inputFormatter.date(from: self) else { return "" }

        return dateTime.timeAgoString(fallbackFormattedDate: self)
    }
}
