//
//  APILevelTidbit.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct APILevelTidbit: View {
    @Environment(\.lemmyAPIClient) var client
    let explicitVersion: LemmyAPIFactory.APIVersion?
    
    init(_ explicitVersion: LemmyAPIFactory.APIVersion? = nil) {
        self.explicitVersion = explicitVersion
    }
    
    init(_ explicitClient: LemmyAPIClient) {
        self.explicitVersion = explicitClient.versionLevel
    }
    
    var version: LemmyAPIFactory.APIVersion { explicitVersion ?? client.versionLevel }
    
    var accentColor: Color {
        switch version {
        case .v1: return Color.blue
        case .v2: return Color.purple
        }
    }
    
    var body: some View {
        KeyValueTidbit(key: "API", value: version.rawValue)
            .accentColor(accentColor)
    }
}

struct APILevelTidbit_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            APILevelTidbit(.v1)
            APILevelTidbit(.v2)
        }
        .previewLayout(.sizeThatFits)
        
        Group {
            APILevelTidbit(.v1)
            APILevelTidbit(.v2)
        }
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
