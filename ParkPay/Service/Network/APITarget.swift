//
//  APITarget.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APITarget {
    case parkingLots(request: ParkingLotsRequest)
}

extension APITarget {
    var path: String {
        switch self {
        case .parkingLots: 
            return "/api/parks"
        }
    }

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .parkingLots(let request):
            return request.toDictionary()
        }
    }
}
