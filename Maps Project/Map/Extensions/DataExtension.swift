//
//  DataExtension.swift
//  Maps Project
//
//  Created by Danylo Klymov on 21.02.2022.
//

import Foundation

extension Data {
    static func parseJson<T: Codable>(_ data: Data, expacting: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodateData = try decoder.decode(expacting, from: data)
            return decodateData
        } catch {
            return nil
        }
    }
}
