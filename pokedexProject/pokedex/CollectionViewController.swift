//
//  CollectionViewController.swift
//  pokedex
//
//  Created by Patrick Zhu on 9/24/20.
//  Copyright © 2020 Patrick Zhu. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    let dataSource: [Pokemon] = PokemonGenerator.getPokemonArray()
    var nameArray = [String]()
    var urlArray = [String]()
    var currIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        createNameArray()
        createURLArray()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        
        currIndex = indexPath.row
        cell.pokemonNameLabel.text = nameArray[currIndex]
        cell.configurePFP(with: urlArray[currIndex])
        return cell
//        if let pokemonName = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
//            createNameArray()
//           pokemonName.configurePokemonName(with: nameArray[indexPath.row])
//            cell = pokemonName
//        }
//
//        if let imageURL = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
//            createURLArray()
//            imageURL.configurePFP(with: urlArray[indexPath.row])
//            cell = imageURL
    }
    
    func createNameArray() -> Void {
        for pokemon in dataSource {
            nameArray.append(String(pokemon.id) + ": " + pokemon.name)
            urlArray.append(pokemon.imageUrl)
        }
    }
    
    func createURLArray() -> Void {
        for pokemon in dataSource {
            urlArray.append(pokemon.imageUrl)
        }
    }
    
}
