//
//  LoadableView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

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
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                Spacer()
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
