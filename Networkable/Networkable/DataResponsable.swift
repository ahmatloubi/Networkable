//
//  DataResponsable.swift
//
//
//  Created by Amir Hossein on 12/09/2024.
//

import Foundation
import Alamofire

public protocol DataResponsable {
    func response<Output>(dataResponse: DataResponse<Output, AFError>)
    throws -> Output where Output: Decodable
}

public extension DataResponsable {
    func response<Output>(dataResponse: DataResponse<Output, AFError>)
    throws -> Output where Output: Decodable {
        switch dataResponse.result {
        case .success(let value):
            return value
        case .failure(let afError):
            print("Error received from AlamoFire: \(afError)")
            throw afError
        }
    }
}

public protocol ResponseErrorHandlable {
    func decodeError(_ bodyErrorData: Data) throws -> Error
}

public extension DataResponsable where Self: ResponseErrorHandlable {
    func response<Output>(dataResponse: DataResponse<Output, AFError>)
    async throws -> Output where Output: Decodable {
        switch dataResponse.result {
        case .success(let value):
            return value
        case .failure(let afError):
            print("Error received from AlamoFire: \(afError)")
            if let data = dataResponse.data {
                let error = try decodeError(data)
                throw error
            }
            throw afError
        }
    }
}


