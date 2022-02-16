//
//  PhotoViewCell.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/16/22.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func applyImage(image: UIImage) {
        imageView.image = nil
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.image = image
        }
    }
}
