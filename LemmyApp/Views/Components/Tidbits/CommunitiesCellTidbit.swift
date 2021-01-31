//
//  CommunitiesCellTidbit.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct CommunitiesCellTidbit: View {
    let numberOfCommunities: Int
    
    var body: some View {
        NavigationLink(destination: LoadableCommunitiesView()) {
            ImageCellTidbit(image: Image(systemName: "bubble.left.and.bubble.right"), line1: "\(numberOfCommunities)", line2: "Communities")
        }
    }
}

struct CommunitiesCellTidbit_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesCellTidbit(numberOfCommunities: 80)
    }
}
