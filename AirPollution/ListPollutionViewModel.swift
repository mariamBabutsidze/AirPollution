//
//  ListPollutionViewModel.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

import Foundation

class ListPollutionViewModel: ObservableObject {
    @Published var pollutionList: [AirQuality] = []
    @Published var error: NetworkError?
    let pollutionFetcher: PolutionFetcher
    
    init(pollutionFetcher: PolutionFetcher) {
        self.pollutionFetcher = pollutionFetcher
    }
    
    @MainActor
    func loadPollutionData() async {
        do {
            let result = try await pollutionFetcher.fetchPollution(urlRequest: PollutionRequest())
            pollutionList = result.list
        } catch {
            self.error = error as? NetworkError
        }
    }
    
}
