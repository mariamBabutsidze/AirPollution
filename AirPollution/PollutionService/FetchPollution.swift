//
//  FetchPollution.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

protocol PolutionFetcher {
    func fetchPollution(urlRequest: PollutionRequest) async throws -> AirQualityResponse
}

class FetchPollution: PolutionFetcher {
    func fetchPollution(urlRequest: PollutionRequest) async throws -> AirQualityResponse {
        return try await NetworkManager.shared.createRequest(with: urlRequest)
    }
}
