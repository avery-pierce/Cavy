//
//  UsersCellTidbit.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct UsersCellTidbit: View {
    let numberOfUsers: Int
    
    var body: some View {
        ImageCellTidbit(image: Image(systemName: "person.3"), line1: "\(numberOfUsers)", line2: "Users")
    }
}

struct UsersCellTidbit_Previews: PreviewProvider {
    static var previews: some View {
        UsersCellTidbit(numberOfUsers: 100)
    }
}
