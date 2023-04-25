//
//  UserAndPosts.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 25.04.23.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var postCount: Int {posts.count}
}
