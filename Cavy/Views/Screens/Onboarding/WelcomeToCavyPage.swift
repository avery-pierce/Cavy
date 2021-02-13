//
//  WelcomeToCavyPage.swift
//  Cavy
//
//  Created by Avery Pierce on 2/13/21.
//

import SwiftUI

struct WelcomeToCavyPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.secondary.opacity(0.5))
                .overlay(Text("(Place Image Here)"))
            
            Text("Welcome to Cavy")
                .font(.title)
            
            Text("Cavy connects you to Lemmy instances around the world.")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Lemmy is a federated link aggregator. Instances are independently owned and moderated.")
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct WelcomeToCavyPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
