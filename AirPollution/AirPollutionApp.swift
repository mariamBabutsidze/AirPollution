//
//  AirPollutionApp.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

import SwiftUI

@main
struct AirPollutionApp: App {
    var body: some Scene {
        WindowGroup {
            ListPollutionView(viewModel: ListPollutionViewModel(pollutionFetcher: FetchPollution()))
        }
    }
}
