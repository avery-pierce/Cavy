//
//  EndlessPostListView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/19/21.
//

import SwiftUI
import Combine

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

class EndlessPostLoader: ObservableObject {
    let intent: ListingIntent
    @Published var pages: [ParsedDataResource<CavyPostListing>] = []
    
    lazy var pageStates = $pages.flatMap({ (resources) -> AnyPublisher<[LoadState<CavyPostListing, Error>], Never> in
        
        let pagePublishers = resources.map(\.$state)
        return combineLatestAll(pagePublishers)
    })
    
    /// is true when any of the pages are loading
    lazy var isNextPageLoading = pageStates.map({ resources -> Bool in
        return resources.contains(where: { !$0.isComplete })
    })
    
    /// represents all of the posts in the data set
    lazy var loadedPosts = pageStates.map({ resources -> [CavyPost] in
        resources.flatMap({ $0.value?.cavyPosts ?? [] })
    })
    
    @Published var posts: [CavyPost] = []
    @Published var nextPageLoading: Bool = false
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ intent: ListingIntent) {
        self.intent = intent
        
        loadedPosts
            .assign(to: \.posts, on: self)
            .store(in: &cancelBag)
        
        isNextPageLoading
            .assign(to: \.nextPageLoading, on: self)
            .store(in: &cancelBag)
    }
    
    func loadNextPage() {
        let nextResource = intent.createResource(limit: 50, pageNumber: nextPageNumber)
        pages.append(nextResource)
        nextResource.load()
    }
    
    func loadNextPageIfNeeded() {
        if !nextPageLoading {
            loadNextPage()
        }
    }
    
    func loadFirstPage() {
        guard pages.isEmpty else { return }
        loadNextPage()
    }
    
    // Page number starts at 1.
    private var nextPageNumber: Int {
        pages.count + 1
    }
}
