//
//  SortModeView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/20/21.
//

import SwiftUI

struct SortModeView: View {
    let sortMode: LemmyAPIFactory.SortType
    init(_ sortMode: LemmyAPIFactory.SortType) {
        self.sortMode = sortMode
    }
    
    var systemName: String {
        switch sortMode {
        case .hot: return "flame"
        case .new: return "hourglass"
        case .active: return "exclamationmark.bubble"
        case .topDay, .topWeek, .topMonth, .topYear, .topAll: return "crown"
        }
    }
    
    var body: some View {
        Image(systemName: systemName)
    }
}

struct SortModeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SortModeView(.hot)
            SortModeView(.new)
            SortModeView(.active)
            SortModeView(.topAll)
            SortModeView(.topDay)
            SortModeView(.topWeek)
            SortModeView(.topMonth)
            SortModeView(.topYear)
        }
        .previewLayout(.sizeThatFits)
    }
}
