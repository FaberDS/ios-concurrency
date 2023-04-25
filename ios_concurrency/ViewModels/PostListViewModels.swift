//
//  PostListViewModels.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 25.04.23.
//

import Foundation


class PostListViewModels: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    var userId: Int?
    
    @MainActor
    func fetchPosts() async {
        guard let userId = userId  else{ return }
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
        do {
            posts = try await apiService.getData()
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
}

extension PostListViewModels {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockPosts
        }
    }
}
