//
//  Encodable+Extensions.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json as? [String: Any] ?? [:]
        } catch {
            print("💥 Encode to Dictionary error: \(error)")
            return [:]
        }
    }

    func toQueryItems() -> [URLQueryItem] {
        let mirror = Mirror(reflecting: self)
        return mirror.children.compactMap { child in
            guard let key = child.label else { return nil }
            return URLQueryItem(name: key, value: "\(child.value)")
        }
    }
}
