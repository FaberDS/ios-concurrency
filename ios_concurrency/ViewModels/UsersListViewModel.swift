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
    
    func fetchUsers(){
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
            apiService.getData { (result: Result<[User], APIError>) in
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
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

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
}
