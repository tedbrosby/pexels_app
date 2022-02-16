//
//  ViewController.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/15/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    private var bag = DisposeBag()
    private var viewModel = ViewModel()
    private var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.register(UINib(nibName: "PhotoViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PhotoViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadPlaceholderImages()
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self,
                      let result = event.element else { return }
                switch result {
                case .success(let photoResult):
                    self.photos = photoResult.photos
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: bag)
    }
    
    private func searchForImages(_ query: String) {
        viewModel.loadImages(query)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self,
                      let result = event.element else { return }
                switch result {
                case .success(let photoResult):
                    self.photos = []
                    self.photos = photoResult.photos
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: bag)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        guard let photoViewCell: PhotoViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoViewCell,
              let imageUrl = URL(string: photo.src.small) else {
            fatalError("You should be using \(PhotoViewCell.self) as the UICollectionViewCell")
        }
        let imageRequest = ImageRequest(url: imageUrl)
        imageRequest.execute()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let _ = self,
                      let result = event.element else { return }
                switch result {
                case .success(let image):
                    photoViewCell.applyImage(image: image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.bag)
        return photoViewCell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        print(photo.url)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField == textField {
            guard let query = searchTextField.text else { return true }
            searchForImages(query)
        }
        return true
    }
}
