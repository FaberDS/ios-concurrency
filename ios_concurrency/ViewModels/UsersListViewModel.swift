//
//  UsersListViewModel.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 25.04.23.
//

import Foundation
class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async{
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        
        do {
            users = try await apiService.getData()

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
            self.users = User.mockUsers
        }
    }
}
