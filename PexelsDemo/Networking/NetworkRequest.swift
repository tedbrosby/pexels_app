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
                guard let self = self else { return }
                if let data = data,
                   let value = self.decode(data) {
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

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}
