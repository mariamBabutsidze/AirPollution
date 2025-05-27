//
//  PollutionRequest.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

struct PollutionRequest: RequestProtocol {
    var host: String = "api.openweathermap.org/"
    
    var path: String = "data/2.5/air_pollution/history?"
    
    var requestType: RequestType = .GET
    
    var query: [String : String?] = ["lat": "41.69411",
                                     "lon": "44.83368",
                                     "start": "1747526400",
                                     "end": "1747996799",
                                     "appid": "018528b54251ae5f8d7ee31a259a0e97"
    ]
    
}

