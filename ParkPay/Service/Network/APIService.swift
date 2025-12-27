//
//  APIService.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import Foundation

class APIService {
    static let shared = APIService()

    // Properties
    private let baseURL = "http://192.168.50.139:5999"
    private let session: URLSession

    // Initial
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: configuration)
    }
}

// MARK: - Public Methods
extension APIService {
    func request<T: Decodable>(target: APITarget) async throws -> T {
        guard let url = requestURL(target: target) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.noResponse
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse(statusCode: httpResponse.statusCode)
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }

        } catch let error as APIError {
            throw error

        } catch {
            throw APIError.networkError(error)
        }
    }
}

// MARK: - 🔒 Private Methods
private extension APIService {
    func requestURL(target: APITarget) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL + target.path) else {
            return nil
        }
        if !target.urlQueryItems.isEmpty {
            urlComponents.queryItems = target.urlQueryItems
        }
        return urlComponents.url
    }
}
