//
//  EndlessPostLoader.swift
//  Cavy
//
//  Created by Avery Pierce on 2/20/21.
//

import Foundation
import Combine

class EndlessPostLoader: ObservableObject {
    var intent: ListingIntent
    @Published var pages: [ParsedDataResource<CavyPostListing>] = []
    @Published var posts: [CavyPost] = []
    @Published var nextPageLoading: Bool = false
    
    private var cancelBag = Set<AnyCancellable>()
    
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
    
    init(_ intent: ListingIntent) {
        self.intent = intent
        
        loadedPosts
            .assign(to: \.posts, on: self)
            .store(in: &cancelBag)
        
        isNextPageLoading
            .assign(to: \.nextPageLoading, on: self)
            .store(in: &cancelBag)
    }
    
    func changeSort(to sortMode: LemmyAPIFactory.SortType) {
        intent.sortType = sortMode
        pages = []
        loadFirstPage()
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
