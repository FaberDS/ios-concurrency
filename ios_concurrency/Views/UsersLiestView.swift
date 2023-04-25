//
//  ContentView.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 24.04.23.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject var vm = UsersListViewModel(forPreview: true)
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.userAndPosts) { userAndPosts in
                    NavigationLink {
                        PostsListView(posts: userAndPosts.posts)
                    } label: {
                        VStack(alignment: .leading){
                            HStack {
                                Text(userAndPosts.user.name)
                                    .font(.title)
                                Spacer()
                                Text("(\(userAndPosts.postCount))")
                            }
                            
                            Text(userAndPosts.user.email)
                        }
                    }
                }
            }.overlay {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .alert("ApplicationErrror", isPresented: $vm.showAlert,actions:{
                Button("Ok"){}
            }, message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
                .listStyle(.plain)
                .task {
                        await vm.fetchUsers()
                }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
