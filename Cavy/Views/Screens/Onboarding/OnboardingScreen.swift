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
            
            HStack {
                Spacer()
                Text("Select an Instance")
                    .bold()
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.blue))
            .foregroundColor(.white)
            .padding()
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
