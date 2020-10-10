//
//  ImageLoader.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import UIKit

struct ImageProcessingError: Error, LocalizedError {
    var errorDescription: String? { return "Could not parse the image" }
}

class ImageLoader: ObservableObject {
    @Published var state: LoadState<UIImage, Error> = .idle
    
    let request: URLRequest
    init(_ request: URLRequest) {
        self.request = request
    }
    
    convenience init(_ url: URL) {
        let request = URLRequest(url: url)
        self.init(request)
    }
    
    func load() {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.state = .complete(.failure(error))
            }
            
            guard let image = UIImage(data: data!) else {
                self.state = .complete(.failure(ImageProcessingError()))
                return
            }
            
            DispatchQueue.main.async {            
                self.state = .complete(.success(image))
            }
        }.resume()
    }
}
