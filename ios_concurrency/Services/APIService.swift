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
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            }catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    func getData<T:Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                              completion: @escaping (Result<T,APIError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))

                return
            }
            guard error == nil  else {
                completion(.failure(.dataTaskError(error!.localizedDescription)))
                return
            }
            guard let data = data else{
                completion(.failure(.corruptedData))

                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }.resume()
        
    }
}

