//
//  Post.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 24.04.23.
//

import Foundation
//https://jsonplaceholder.typicode.com/posts

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
