//
//  PollutionView.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

import SwiftUI

struct PollutionView: View {
    let airQuality: AirQuality
    
    var body: some View {
        VStack {
            Text(airQuality.main.quality.description)
            Text(airQuality.date)
        }
    }
}

#Preview {
    PollutionView(airQuality: .init(main: .init(aqi: 2), components: .init(co: 1, no: 1, no2: 1, o3: 1, so2: 1, pm2_5: 1, pm10: 1, nh3: 1), dt: 1747526400))
}
