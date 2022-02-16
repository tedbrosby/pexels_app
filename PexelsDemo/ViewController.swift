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
    
    @IBOutlet var imageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let viewModel = ViewModel()
        viewModel.loadImages("corgi")
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let _ = self,
                      let result = event.element else { return }
                switch result {
                case .success(let photoResult):
                    print(photoResult.photos)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: bag)
    }
}

