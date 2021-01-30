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
    
    convenience init<D, T1: CavyCommentListing>(_ spec: Spec<D, T1>) where T == CavyCommentListing {
        self.init(spec.dataProvider, parsedBy: jsonParser(spec.type))
    }
    
    convenience init<D, T1: CavyPostListing>(_ spec: Spec<D, T1>) where T == CavyPostListing {
        self.init(spec.dataProvider, parsedBy: jsonParser(spec.type))
    }
    
    convenience init<D, T1: CavySiteConvertable>(_ spec: Spec<D, T1>) where T == CavySiteConvertable {
        self.init(spec.dataProvider, parsedBy: jsonParser(spec.type))
    }
    
    convenience init<D, T1: CavyCommunityListing>(_ spec: Spec<D, T1>) where T == CavyCommunityListing {
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

func typeAdapter<T1, T2>(parser: @escaping (Data) throws -> T1, adapter: @escaping (T1) throws -> T2) -> (Data) throws -> T2 {
    return { (_ data: Data) throws -> T2 in
        let t1 = try parser(data)
        let t2 = try adapter(t1)
        return t2
    }
}
