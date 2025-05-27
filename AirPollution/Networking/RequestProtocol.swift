//
//  RequestProtocol.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//
import Foundation

protocol RequestProtocol {
    var host: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var body: [String: Any] { get }
    var query: [String: String?] { get }
    var requestType: RequestType { get }
}

extension RequestProtocol {
    var body: [String: Any] {
      [:]
    }
    
    var query: [String: String?] {
      [:]
    }
    
    var headers: [String: String] {
      [:]
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents(string: host + path)
        components?.scheme = "http"
        
        if !query.isEmpty {
            components?.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !body.isEmpty && request.httpMethod != RequestType.GET.rawValue {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        Log.logger.log("Request: \(request)")
        return request
    }
}
