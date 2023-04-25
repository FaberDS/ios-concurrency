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
    case dataTaskError
    case corruptedData
    case decodingError
}
