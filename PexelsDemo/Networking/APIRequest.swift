//
//  APIRequest.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/15/22.
//

import RxSwift
import Foundation

class APIRequest<Resource: APIResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(Resource.ModelType.self, from: data)
        return wrapper
    }
    
    func execute() -> Observable<Result<Resource.ModelType, Error>> {
        load(resource.url)
    }
}
