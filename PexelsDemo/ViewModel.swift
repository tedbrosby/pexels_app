//
//  ViewModel.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/15/22.
//

import Foundation
import RxSwift

protocol ViewModelType {
    func loadPlaceholderImages() -> Observable<Result<PhotosResult, Error>>
    func loadImages(_ query: String) -> Observable<Result<PhotosResult, Error>>
}

class ViewModel: ViewModelType {
    var request: APIRequest<PhotosResource>? = nil
    func loadPlaceholderImages() -> Observable<Result<PhotosResult, Error>> {
        let resource = PhotosResource("corgi")
        let request = APIRequest<PhotosResource>(resource: resource)
        self.request = request
        return request.execute()
    }
    func loadImages(_ query: String) -> Observable<Result<PhotosResult, Error>> {
        let resource = PhotosResource(query)
        let request = APIRequest<PhotosResource>(resource: resource)
        self.request = request
        return request.execute()
    }
}
