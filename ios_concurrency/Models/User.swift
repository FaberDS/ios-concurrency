//
//  User.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 24.04.23.
//

import Foundation

//https://jsonplaceholder.typicode.com/users
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
