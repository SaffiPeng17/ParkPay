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
    case parkingLotInfo(parkID: String)
}

extension APITarget {
    var path: String {
        switch self {
        case .parkingLots:
            return "/api/parks"
        case .parkingLotInfo(let parkID):
            return "/api/parks/" + parkID
        }
    }

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var urlQueryItems: [URLQueryItem] {
        switch self {
        case .parkingLots(let request):
            return request.toQueryItems()
        default:
            return []
        }
    }
}
