//
//  UsersListViewModel.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 25.04.23.
//

import Foundation
class UsersListViewModel: ObservableObject {
    
    @Published var userAndPosts: [UserAndPosts] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async{
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        let apiServicePosts = APIService(urlString: "https://jsonplaceholder.typicode.com/posts")
        isLoading.toggle()
        
        do {
            async let users: [User] = try await apiService.getData()
            async let posts: [Post] = try await apiServicePosts.getData()
            let (fetchedUsers, fetchedPosts) = try await (users,posts)
            fetchedUsers.forEach { user in
                let userPosts = fetchedPosts.filter{ $0.userId == user.id}
                let newUserAndPosts = UserAndPosts(user: user, posts: userPosts)
                userAndPosts.append(newUserAndPosts)
            }
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.userAndPosts = UserAndPosts.mockUserAndPosts
        }
    }
}

