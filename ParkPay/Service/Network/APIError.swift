//
//  APIError.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

enum APIError: Error {
    case invalidURL
    case noResponse
    case invalidResponse(statusCode: Int)
    case networkError(Error)
    case decodingError(Error)

    var message: String {
        switch self {
        case .invalidURL:
            return "💥 Invalid URL"
        case .noResponse:
            return "💥 No response received"
        case .invalidResponse(statusCode: let code):
            return "💥 Invalid response status code: \(code)"
        case .networkError(let error):
            return "💥 Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "💥 Decoding error: \(error.localizedDescription))"
        }
    }
}
