//
//  PostDetailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct PostDetailView: View {
    let post: PostItem
    
    var body: some View {
        ScrollView {
            VStack {
                Text(post.body ?? "No Body Content")
            }
        }.onAppear(perform: printMe)
    }
    
    func printMe() {
        print(post)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(post: sampleData)
        }
    }
}
