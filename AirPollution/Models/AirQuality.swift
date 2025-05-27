//
//  AirQuality.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

import Foundation

// MARK: - Root
struct AirQualityResponse: Decodable {
    let coord: Coord
    let list: [AirQuality]
}

// MARK: - Coord
struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

// MARK: - AirQuality
struct AirQuality: Decodable {
    let main: Main
    let components: Components
    let dt: Int // timestamp
    
    var date: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))

        // Format the Date to a readable format
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let readableDate = dateFormatter.string(from: date)
        return readableDate
    }
}

// MARK: - Main
struct Main: Decodable {
    let aqi: Int
    
    var quality: AirQualityIndex {
        AirQualityIndex(rawValue: aqi) ?? .good
    }
}

// MARK: - Components
struct Components: Decodable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}

enum AirQualityIndex: Int {
    case good = 1
    case fair = 2
    case moderate = 3
    case poor = 4
    case veryPoor = 5
    
    var description: String {
        switch self {
        case .good:
            return "Good"
        case .fair:
            return "Fair"
        case .moderate:
            return "Moderate"
        case .poor:
            return "Poor"
        case .veryPoor:
            return "Very Poor"
        }
    }
}
