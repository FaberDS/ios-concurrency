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
    
    func fetchPosts(){
        guard let userId = userId  else{ return }
        isLoading.toggle()
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
        apiService.getData { (result: Result<[Post], APIError>) in
            defer {
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                }
                
            }
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async{
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                }
            }

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
