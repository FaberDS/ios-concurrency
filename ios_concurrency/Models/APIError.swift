//
//  APIError.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 24.04.23.
//

import Foundation


enum APIError: Error{
    case invalidURL
    case invalidResponse
    case dataTaskError(String)
    case corruptedData
    case decodingError(String)
}

extension APIError: LocalizedError{
    var errorDescription: String? {
        switch self {
        case .invalidURL: return NSLocalizedString("The endpoint URL is invalid", comment: "")
        case .invalidResponse : return NSLocalizedString("The API failed to issue a valid response", comment: "")
        case .dataTaskError(let string): return string
        case .corruptedData: return NSLocalizedString("The data provided appears to be corrupt", comment: "")
        case .decodingError(let string): return string
        }
    }
    
}
