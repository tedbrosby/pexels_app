//
//  NetworkRequest.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/15/22.
//

import Foundation
import RxSwift

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute() -> Observable<Result<ModelType, Error>>
}

extension NetworkRequest {
    func load(_ request: URLRequest) -> Observable<Result<ModelType, Error>> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                if let data = data,
                   let value = self?.decode(data) {
                    observer.onNext(.success(value))
                }
                if let error = error {
                    observer.onNext(.failure(error))
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
