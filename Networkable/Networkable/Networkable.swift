//
//  Networkable.swift
//
//
//  Created by Amir Hossein on 15/09/2024.
//

import Foundation

public protocol Networkable: DataRequestable, DataResponsable {
    func fetchValueOf<R>(request: R) async throws -> R.RequestOutput where R: Request
}

public extension Networkable {
    func fetchValueOf<R>(request: R) async throws -> R.RequestOutput where R: Request {
        var dataRequest = try await dataRequest(from: request)
        var dataResponse = await dataRequest.serializingDecodable(R.RequestOutput.self).response
        return try await response(dataResponse: dataResponse)
    }
}
