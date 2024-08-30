//
//  Data+Addition.swift
//  FMCServices
//
//  Created by Shivanshu Verma on 15/05/24.
//  Copyright © 2024 Shivanshu Verma. All rights reserved.
//

import Foundation

/// Extension for Data type providing a method to serialize JSON data.
extension Data {
    /// Serializes the JSON data contained in the Data instance.
    /// - Parameter outputFormatting: Options for writing the JSON data.
    /// - Returns: Serialized JSON data.
    /// - Throws: An error if the JSON serialization fails.
    ///
    /// This method attempts to parse the JSON data contained within the Data instance
    /// and serialize it using the JSONSerialization class. The resulting serialized
    /// JSON data is then returned.
    ///
    /// Example:
    /// ```swift
    /// let jsonData = try Data(contentsOf: url)
    /// let serializedData = try jsonData.serializeJSON()
    /// ```
    ///
    /// - Note: This method assumes that the JSON data contained in the Data instance
    ///   is valid JSON. If the data is not valid JSON, an error will be thrown.
    ///
    /// - SeeAlso: `JSONSerialization`
    func serializeJSON(_ outputFormatting: JSONSerialization.WritingOptions = .prettyPrinted) throws -> Data {
        let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
        return try JSONSerialization.data(withJSONObject: jsonObject, options: [outputFormatting, .sortedKeys])
    }
}
