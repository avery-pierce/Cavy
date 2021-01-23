//
//  LoadableView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

/// Renders an activity indicator while the content is loading
struct LoadStateView<T, E: Error, V: View>: View {
    let loadState: LoadState<T, E>
    let contentView: (T) -> V
    
    init(_ loadState: LoadState<T, E>, view: @escaping (T) -> V) {
        self.loadState = loadState
        self.contentView = view
    }
    
    var body: some View {
        switch loadState {
        case .idle, .loading:
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    ProgressView()
                }
            }
        
        case .complete(let result):
            switch result {
            case .success(let value):
                contentView(value)
            
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
    }
}
