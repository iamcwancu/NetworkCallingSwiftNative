//
//  JsonRelated.swift
//
//  Created by Shivanshu Verma on 29/04/24.
//

import Foundation

/// Extension on `Encodable` protocol to convert an instance of a type conforming to `Encodable` into a JSON string.
extension Encodable {

    /// Converts the instance of a type conforming to `Encodable` into a JSON string.
    ///
    /// - Returns: A JSON string representing the instance, or `nil` if conversion fails.
    ///
    /// Example:
    /// ```swift
    /// struct User: Codable {
    ///     var name: String
    ///     var age: Int
    /// }
    ///
    /// let user = User(name: "John", age: 30)
    /// let jsonString = user.toJSONString()
    /// print(jsonString) // {"name":"John","age":30}
    /// ```
    ///
    /// - Note: This method uses `JSONEncoder` to encode the instance into JSON data, and then converts the data into a UTF-8 encoded string.
    func toJSONString() -> String? {
        /// Encode the instance into JSON data using JSONEncoder
        guard let jsonData = try? JSONEncoder().encode(self),
              let serializeData = try? jsonData.serializeJSON()
        else { return nil }
        /// Convert the JSON data into a UTF-8 encoded string
        return String(data: serializeData, encoding: .utf8)
    }
    /// Encodes the object into JSON data.
    /// - Returns: JSON data representing the object.
    /// - Throws: An error if encoding fails.
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
/// Extension for Dictionary type providing methods to convert dictionaries to JSON data and JSON strings.
extension Dictionary where Key == String, Value == Any {
    /// Converts the dictionary to a JSON string.
    /// - Parameter outputFormatting: Options for writing the JSON string. Default value is `.prettyPrinted`.
    /// - Returns: A JSON string representing the dictionary.
    /// - Throws: An error if the JSON serialization fails or if the conversion to string fails.
    func jsonString(_ outputFormatting: JSONSerialization.WritingOptions = .prettyPrinted) throws -> String {
        let jsonData = try self.jsonData(outputFormatting)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw "Unable to convert JSON data to string" as! any Error
        }
        return jsonString
    }
    /// Converts the dictionary to JSON data.
    /// - Parameter outputFormatting: Options for writing the JSON data. Default value is `.prettyPrinted`.
    /// - Returns: JSON data representing the dictionary.
    /// - Throws: An error if the JSON serialization fails.
    func jsonData(_ outputFormatting: JSONSerialization.WritingOptions = .prettyPrinted) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: [outputFormatting, .sortedKeys])
    }
    /// Decodes a dictionary `[String: Any]` into the specified Codable type.
    /// - Parameter type: The Codable type to decode into.
    /// - Returns: An instance of the specified Codable type.
    /// - Throws: An error if decoding fails.
    ///
    /// This function decodes a dictionary `[String: Any]` into the specified Codable type using `JSONSerialization`
    /// and `JSONDecoder`. If decoding fails, an error is thrown.
    ///
    /// Example:
    /// ```swift
    /// let dictionary: [String: Any] = ["name": "John", "age": 30]
    /// do {
    ///     let person = try dictionary.decode(Person.self)
    ///     print(person)
    /// } catch {
    ///     print("Decoding failed: \(error)")
    /// }
    /// ```
    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        let data = try self.jsonData()
        return try JSONDecoder().decode(T.self, from: data)
    }
}

/// Extension for Dictionary type providing methods to convert dictionaries to JSON data and JSON strings.
extension Dictionary where Key == AnyHashable, Value == Any {
    /// Converts the dictionary to a JSON string.
    /// - Parameter outputFormatting: Options for writing the JSON string. Default value is `.prettyPrinted`.
    /// - Returns: A JSON string representing the dictionary.
    /// - Throws: An error if the JSON serialization fails or if the conversion to string fails.
    func jsonString(_ outputFormatting: JSONSerialization.WritingOptions = .prettyPrinted) throws -> String {
        let jsonData = try self.jsonData(outputFormatting)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw NSError(domain: "DictionaryExtension", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to convert JSON data to string"])
        }
        return jsonString
    }

    /// Converts the dictionary to JSON data.
    /// - Parameter outputFormatting: Options for writing the JSON data. Default value is `.prettyPrinted`.
    /// - Returns: JSON data representing the dictionary.
    /// - Throws: An error if the JSON serialization fails.
    func jsonData(_ outputFormatting: JSONSerialization.WritingOptions = .prettyPrinted) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: [outputFormatting, .sortedKeys])
    }

    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        let data = try self.jsonData()
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension String {
    /// Converts the JSON string representation to a dictionary.
    ///
    /// - Returns: A dictionary representation of the JSON string, or `nil` if the conversion fails.
    func convertJSONStringToDictionary() -> [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? nil
    }
}
extension String {
    /// Decodes a JSON string into the specified Codable type.
    ///
    /// - Parameters:
    ///   - type: The type to decode the JSON string into. Must conform to Decodable.
    /// - Returns: An instance of the specified type if decoding succeeds, or `nil` if decoding fails.
    func decodeJSON<T>(to type: T.Type) -> T? where T: Decodable {
        /// Convert the JSON string to data using UTF-8 encoding
        guard let jsonData = data(using: .utf8) else {
            FMCLogger.log("Failed to convert JSON string to data.")
            return nil
        }
        do {
            /// Decode the JSON data into the specified type
            return try JSONDecoder().decode(type, from: jsonData)
        } catch let error as DecodingError {
            /// Print DecodingError along with codingPath and debugDescription
            switch error {
                case .typeMismatch(_, let context):
                    FMCLogger.log("--- Decoding Error ---")
                    FMCLogger.log("Coding Path: \(context.codingPath)")
                    FMCLogger.log("Description: \(context.debugDescription)")
                    /// Handle other DecodingError cases if needed
                default:
                    FMCLogger.log("Decoding Error: \(error)")
            }
        } catch {
            FMCLogger.log("Error decoding JSON: \(error)")
        }
        return nil
    }
}
