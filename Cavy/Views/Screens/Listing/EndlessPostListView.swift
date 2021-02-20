//
//  EndlessPostListView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/19/21.
//

import SwiftUI

struct EndlessPostListView: View {
    @ObservedObject var postLoader: EndlessPostLoader
    @State var showingSortPopover: Bool = false
    
    var intent: ListingIntent { postLoader.intent }
    
    init(_ intent: ListingIntent) {
        self.postLoader = EndlessPostLoader(intent)
    }
    
    var activeClient: LemmyAPIClient {
        intent.client
    }
    
    var barButtonItems: some View {
        HStack {
            Button(action: { showingSortPopover = true }, label: {
                SortModeView(intent.sortType)
            })
            .actionSheet(isPresented: $showingSortPopover, content: {
                ActionSheet(title: Text("Choose a sort order"), message: nil, buttons: [
                    .default(Text("Hot"), action: { postLoader.changeSort(to: .hot) }),
                    .default(Text("New"), action: { postLoader.changeSort(to: .new)}),
                    .default(Text("Active"), action: { postLoader.changeSort(to: .active)}),
                    .default(Text("Top Day"), action: { postLoader.changeSort(to: .topDay)}),
                    .default(Text("Top Week"), action: { postLoader.changeSort(to: .topWeek)}),
                    .default(Text("Top Month"), action: { postLoader.changeSort(to: .topMonth)}),
                    .default(Text("Top Year"), action: { postLoader.changeSort(to: .topYear)}),
                    .default(Text("Top All"), action: { postLoader.changeSort(to: .topAll)}),
                ])
            })
            
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
