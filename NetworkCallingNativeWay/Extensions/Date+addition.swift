import Foundation

extension Date {
    /**
     Returns a string representing the time ago from the current date to the receiver (self).
     
     If the time difference is more than a day, it falls back to formatting the receiver date as a specified format.
     
     - Parameters:
     - fallbackFormattedDate: A string representing the fallback date format (e.g., "yyyy-MM-dd'T'HH:mm:ss.SS").
     
     - Returns: A string representing the time ago from the current date or a formatted date string if more than a day ago.
     */
    func timeAgoString(fallbackFormattedDate: String) -> String {
        let inputFormatter = DateFormatter.iso8601WithFractionalSecondsFormatter

        /// Get current date and time as a string
        let currectDatetimeString = inputFormatter.string(from: Date())

        /// Convert the current date and time string back to a Date object
        guard let currectDatetime = inputFormatter.date(from: currectDatetimeString) else { return "" }

        /// Calculate the time components between self (receiver) and the current date and time
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: self, to: currectDatetime)

        /// Determine the appropriate time ago string or fallback to formatted date string
        if let day = components.day, day > 0 {
            return fallbackFormattedDate.formattedDate(output: "MMM dd, yyyy, h:mm:ss a")
        } else if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        } else if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        } else {
            return "Just now"
        }
    }
}

extension Date {
    /// Computed property to get the current date formatted as "yyyy-MM-dd"
    var formattedAsYearMonthDay: String {
        let dateFormatter = DateFormatter.yearMonthDayFormatter
        return dateFormatter.string(from: self)
    }
}

extension DateFormatter {
    /// Static method to create a date formatter with the specified format
    static func formatter(with format: String = "yyyy-MM-dd'T'HH:mm:ss.SS") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        return formatter
    }

    /// Date formatter for "yyyy-MM-dd'T'HH:mm:ss.SS" format
    static var iso8601WithFractionalSecondsFormatter: DateFormatter {
        return DateFormatter.formatter(with: "yyyy-MM-dd'T'HH:mm:ss.SS")
    }

    /// Date formatter for "yyyy-MM-dd" format
    static var yearMonthDayFormatter: DateFormatter {
        return DateFormatter.formatter(with: "yyyy-MM-dd")
    }
}
