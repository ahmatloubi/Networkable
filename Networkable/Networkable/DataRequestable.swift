//
//  DataRequestable.swift
//
//
//  Created by Amir Hossein on 12/09/2024.
//

import Foundation
import Alamofire

public protocol DataRequestable {
    func dataRequest<R: Request>(from request: R) async throws -> DataRequest
}

extension DataRequestable {
    func dataRequest<R: Request>(from request: R) async throws -> DataRequest {
        let dataRequest: DataRequest
        
        switch request.type {
        case .body:
            dataRequest = AF.request(request.url,
                              method: request.method,
                              parameters: request.parameter,
                              encoder: JSONParameterEncoder.default,
                              headers: request.headers)
        case .queryString:
            let params = request.parameter?.toDictionary
            dataRequest = AF.request(request.url,
                              method: request.method,
                              parameters: params,
                              encoding: URLEncoding.queryString,
                              headers: request.headers)
        }
        
        return dataRequest
    }
}


