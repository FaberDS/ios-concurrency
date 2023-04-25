//
//  PostListView.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 25.04.23.
//

import SwiftUI

struct PostsListView: View {
    
    var posts: [Post]
    var body: some View {
        NavigationView {
            List{
                ForEach(posts) { post in
                    VStack(alignment: .leading){
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
             
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(posts: Post.mockPosts)
        }
    }
}
