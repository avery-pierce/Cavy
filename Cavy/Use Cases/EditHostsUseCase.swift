//
//  AddServerUseCase.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import Foundation

protocol AddServerDelegate: class {
    func useCase(_ useCase: AddServerUseCase, didAddServer: String)
}

class AddServerUseCase: ObservableObject {
    weak var delegate: AddServerDelegate?
    
    var input: String = ""
    
    func submit() {
        delegate?.useCase(self, didAddServer: input)
        input = ""
    }
}
