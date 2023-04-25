//
//  APIService.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 24.04.23.
//

import Foundation

struct APIService {
    let urlString: String
    
    func getData<T:Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    continuation.resume(with: .failure(APIError.invalidResponse))
                    
                    return
                }
                guard error == nil  else {
                    continuation.resume(with: .failure(APIError.dataTaskError(error!.localizedDescription)))
                    return
                }
                guard let data1 = data else{
                    continuation.resume(with: .failure(APIError.corruptedData))
                    
                    return
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy
                do {
                    let decodedData = try decoder.decode(T.self, from: data1)
                    continuation.resume(with: .success(decodedData))
                }catch {
                    continuation.resume(with: .failure(APIError.decodingError(error.localizedDescription)))
                }
            }.resume()
            
        }
    }
}

