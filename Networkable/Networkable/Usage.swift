//
//  Usage.swift
//  Networkable
//
//  Created by Amir Hossein on 26/09/2024.
//

import Foundation

struct RequestModel: Encodable {
    
}

struct ResponseModel: Decodable {
    
}

struct SomeRequest: Request {
    
    typealias RequestInput = RequestModel
    
    typealias RequestOutput = ResponseModel
    
    var method: HttpMethod {
        .get
    }
    
    var url: URL {
        URL(string:"http://someURL.com")!
    }
    
    var parameter: RequestInput? {
        RequestModel()
    }
}

class SomeRepository: Networkable {
    
    func load() async throws -> ResponseModel {
        return try await fetchValueOf(request: SomeRequest())
    }
    
}
