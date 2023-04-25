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
                completion(.failure(.dataTaskError))
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
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
}

