//
//  Request.swift
//
//
//  Created by Amir Hossein on 12/09/2024.
//

import Foundation
import Alamofire

public enum RequestType {
    case body, queryString
}

public protocol Request {
    associatedtype RequestInput: Encodable
    associatedtype RequestOutput: Decodable
    var type: RequestType { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameter: RequestInput? { get }
    var url: URL { get }
}

public extension Request {
    var type: RequestType { .body }
    var headers: HTTPHeaders? { nil }
}

public extension Request where Self.RequestInput == EmptyCodable {
    var parameter: EmptyCodable? { nil }
}

public struct EmptyCodable: Codable, EmptyResponse {
    public static func emptyValue() -> EmptyCodable {
        EmptyCodable()
    }
}

public extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
