//
//  UsersListView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct UsersListView: View {
    let users: [CavyUser]
    init(_ users: [CavyUser]) {
        self.users = users
    }
    
    var body: some View {
        List(users, id:\.id) { user in
            VStack(alignment: .leading, spacing: 12.0) {
                Text(user.name).bold()
                if let bio = user.bio {
                    Text(bio)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UsersListView(LemmySiteResponse.sampleData.admins.map(\.cavyUser))
        }
    }
}
