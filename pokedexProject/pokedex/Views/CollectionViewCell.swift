//
//  CollectionViewCell.swift
//  pokedex
//
//  Created by Patrick Zhu on 9/24/20.
//  Copyright © 2020 Patrick Zhu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    
    func configurePFP(with imageURL: String) {
        guard let imageUrl:URL = URL(string: imageURL) else {
            return
        }
        profilePic.loadImage(withUrl: imageUrl)
    }
    
    //Sets the label text to provided pokemonName
   
}

extension UIImageView {
    func loadImage(withUrl url: URL) {
        DispatchQueue.global().async{ [weak self] in
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
    }
}
