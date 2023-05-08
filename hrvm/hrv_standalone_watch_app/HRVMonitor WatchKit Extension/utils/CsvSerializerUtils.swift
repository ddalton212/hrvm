//
//  CsvSerializerUtils.swift
//  HRVMonitor WatchKit Extension
//
//  Created by bchalpin on 5/23/22.
//

import Foundation

public class CsvSerializerUtils {
    
    public static func serialize<T:Codable>(data: T) -> String {
        do {
            let encodedData = try JSONEncoder().encode(data)
            return String(data: encodedData, encoding: .utf8)!
        }
        catch {
            fatalError("Error occurred when encoding data object. Does it conform to Codable type?")
        }
    }
    
    public static func deserialize<T:Codable>(jsonString: String) -> T {
        do {
            let dataFromJsonString = jsonString.data(using: .utf8)!
            return try JSONDecoder().decode(T.self, from: dataFromJsonString)
        }
        catch {
            fatalError("Error occurred when decoding data object. Does it conform to Codable type?")
        }
    }
}
    
    //    public static func serialize<T:Codable>(data: [T], headers: [String]) -> String {
//        let rows = data.map { (item) -> [String] in
//            let mirror = Mirror(reflecting: item)
//            return mirror.children.map { (child) -> String in
//                String(describing: child.value)
//            }
//        }
//        var csvString = headers.joined(separator: ",") + "\n"
//        for row in rows {
//            let rowString = row.map { (field) -> String in
//                return "\"\(field.replacingOccurrences(of: "\"", with: "\"\""))\""
//            }.joined(separator: ",")
//            csvString.append(rowString + "\n")
//        }
//        return csvString
//    }
//}


//public class JsonSerializerUtils {
//    public static func serialize<T:Codable>(data: T) -> String {
//        do {
//            let encodedData = try JSONEncoder().encode(data)
//            return String(data: encodedData, encoding: .utf8)!
//        }
//        catch {
//            fatalError("Error occurred when encoding data object. Does it conform to Codable type?")
//        }
//    }
//
//    public static func deserialize<T:Codable>(jsonString: String) -> T {
//        do {
//            let dataFromJsonString = jsonString.data(using: .utf8)!
//            return try JSONDecoder().decode(T.self, from: dataFromJsonString)
//        }
//        catch {
//            fatalError("Error occurred when decoding data object. Does it conform to Codable type?")
//        }
//    }
//}
