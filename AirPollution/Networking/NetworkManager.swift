//
//  NetworkManager.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

import Foundation
import OSLog

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func createRequest<T: Decodable>(with request: RequestProtocol) async throws -> T {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            Log.logger.log("InvalidResponse: \(response)")
            throw NetworkError.invalidResponse
        }
        Log.logger.log("Data: \(data)")
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            Log.logger.log(level: .error, "Parsing error \(error)")
            throw error
        }
    }
}

import os

enum Log {
    static let logger = Logger(subsystem: "api.com.networking", category: "networking")
}
