//
//  AirPollutionTests.swift
//  AirPollutionTests
//
//  Created by Mariam Babutsidze on 27.05.25.
//

import Testing
@testable import AirPollution

struct AirPollutionTests {

    // Mock class for PollutionFetcher to simulate the network calls.
    class MockPollutionFetcher: PolutionFetcher {
        var shouldReturnError = false

        func fetchPollution(urlRequest: PollutionRequest) async throws -> AirQualityResponse {
            if shouldReturnError {
                throw NetworkError.invalidURL
            } else {
                let mockData = AirQualityResponse(
                    coord: .init(
                        lon: 3,
                        lat: 3
                    ),
                    list: [.init(
                        main: .init(
                            aqi: 2
                        ),
                        components: .init(
                            co: 1,
                            no: 1,
                            no2: 1,
                            o3: 1,
                            so2: 1,
                            pm2_5: 1,
                            pm10: 1,
                            nh3: 1
                        ),
                        dt: 1747526400
                    )]
                )
                return mockData
            }
        }
    }

    @Test func testLoadPollutionDataSuccess() async throws {
        // Setup
        let mockPollutionFetcher = MockPollutionFetcher()
        let viewModel = ListPollutionViewModel(pollutionFetcher: mockPollutionFetcher)

        // Simulate a successful data fetch
        mockPollutionFetcher.shouldReturnError = false

        // Call the method to fetch data
        await viewModel.loadPollutionData()

        // Expectations: verify the pollutionList is populated correctly
        #expect(viewModel.pollutionList.count == 1)
        #expect(viewModel.pollutionList.first?.main.aqi == 2)
        #expect(viewModel.error == nil)
    }

    @Test func testLoadPollutionDataFailure() async throws {
        // Setup
        let mockPollutionFetcher = MockPollutionFetcher()
        let viewModel = ListPollutionViewModel(pollutionFetcher: mockPollutionFetcher)

        // Simulate a failure (network error)
        mockPollutionFetcher.shouldReturnError = true

        // Call the method to fetch data
        await viewModel.loadPollutionData()

        // Expectations: verify the error is set properly
        #expect(viewModel.pollutionList.isEmpty)
        #expect(viewModel.error == NetworkError.invalidURL)
    }
}

