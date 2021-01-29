//
//  ParsedDataResource.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import UIKit

class ParsedDataResource<T>: ObservableObject, Resource {
    @Published var state: LoadState<T, Error> = .idle
    
    let parser: (Data) throws -> T
    let dataProvider: DataProvider
    
    init(_ dataProvider: DataProvider, parsedBy parser: @escaping (Data) throws -> T) {
        self.dataProvider = dataProvider
        self.parser = parser
    }
    
    func load() {
        state = .loading(nil)
        dataProvider.getData { (result) in
            
            let parsedResult = result.flatMap { data in
                Result<T, Error> { try self.parser(data) }
            }
            
            DispatchQueue.main.async {
                self.state = .complete(parsedResult)
            }
        }
    }
}

extension ParsedDataResource {
    convenience init<D>(_ spec: Spec<D, T>) {
        self.init(spec.dataProvider, parsedBy: jsonParser(spec.type))
    }
}

struct ImageProcessingError: Error, LocalizedError {
    var errorDescription: String? { return "Could not parse the image" }
}

class ImageLoader: ParsedDataResource<UIImage> {
    init(_ dataProvider: DataProvider) {
        super.init(dataProvider, parsedBy: imageParser)
    }
}

func jsonParser<T: Codable>(_ Type: T.Type) -> (Data) throws -> T {
    return { (_ data: Data) throws -> T in
        return try JSONDecoder().decode(T.self, from: data)
    }
}

func imageParser(_ data: Data) throws -> UIImage {
    guard let image = UIImage(data: data) else {
        throw ImageProcessingError()
    }
    return image
}

func passthroughParser(_ data: Data) -> Data {
    return data
}
