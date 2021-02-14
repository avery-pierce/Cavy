//
//  OnboardingNavigationView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import SwiftUI

struct OnboardingNavigationView: View {
    var body: some View {
        NavigationView {
            OnboardingScreen()
        }
    }
}

struct OnboardingNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingNavigationView()
            OnboardingNavigationView()
                .preferredColorScheme(.dark)
        }
    }
}
