//
//  EditHostsView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import SwiftUI

struct EditHostsView: View {
    @ObservedObject var addServerUseCase: AddServerUseCase
    init(_ addServerUseCase: AddServerUseCase) {
        self.addServerUseCase = addServerUseCase
    }
    
    var body: some View {
        Section {
            TextField("Host address", text: $addServerUseCase.input)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Button(action: addServerUseCase.submit) {
                HStack {
                    Spacer()
                    Text("Add")
                    Spacer()
                }
            }
        }
    }
}

struct EditHostsView_Previews: PreviewProvider {
    static var previews: some View {
        EditHostsView(AddServerUseCase())
    }
}
