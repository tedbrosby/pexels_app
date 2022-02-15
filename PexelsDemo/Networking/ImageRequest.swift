//
//  ImageRequest.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/15/22.
//

import UIKit
import RxSwift

class ImageRequest {
    let url: URL
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    func execute() -> Observable<Result<UIImage, Error>> {
        let request = URLRequest(url: url)
        return load(request)
    }
}
