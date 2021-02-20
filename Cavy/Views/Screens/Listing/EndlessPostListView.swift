//
//  EndlessPostListView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/19/21.
//

import SwiftUI

struct EndlessPostListView: View {
    @ObservedObject var postLoader: EndlessPostLoader
    
    let intent: ListingIntent
    init(_ intent: ListingIntent) {
        self.intent = intent
        self.postLoader = EndlessPostLoader(intent)
    }
    
    var activeClient: LemmyAPIClient {
        intent.client
    }
    
    var barButtonItems: some View {
        HStack {
            if let intent = intent {
                ToggleSavedListIntent(intent)
            }
        }
    }
    
    var title: some View {
        let title = intent.title
        let detail = intent.detail
        
        return VStack {
            Text(title).font(.headline)
            if let detail = detail {
                Text(detail).font(.subheadline)
            }
        }
    }
    
    var body: some View {
        ListingView(postLoader.posts, isNextPageLoading: postLoader.nextPageLoading, onLoadNextPage: { postLoader.loadNextPage() })
            .onAppear(perform: {
                postLoader.loadFirstPage()
            })
            .lemmyAPIClient(activeClient)
            .navigationBarItems(trailing: barButtonItems)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    title
                }
            }
    }
}

struct EndlessPostListView_Previews: PreviewProvider {
    static var previews: some View {
        EndlessPostListView(.allPosts(of: .lemmyML))
    }
}
