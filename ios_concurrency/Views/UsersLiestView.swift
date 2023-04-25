//
//  ContentView.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 24.04.23.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject var vm = UsersListViewModel(forPreview: false)
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.users) { user in
                    NavigationLink {
                        PostsListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading){
                            Text(user.name)
                                .font(.title)
                            Text(user.email)
                        }
                    }
                }
            }.overlay {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("Users")
                .listStyle(.plain)
                .onAppear {
                    vm.fetchUsers()
                }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
