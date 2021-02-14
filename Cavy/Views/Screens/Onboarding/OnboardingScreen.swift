//
//  OnboardingScreen.swift
//  Cavy
//
//  Created by Avery Pierce on 2/13/21.
//

import SwiftUI

struct OnboardingScreen: View {
    var body: some View {
        VStack {
            Spacer()
            WelcomeToCavyPage()
            
            NavigationLink(destination: ChooseInstancePage(), label: { FillButton("Select an Instance")
            })
                .padding()
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
