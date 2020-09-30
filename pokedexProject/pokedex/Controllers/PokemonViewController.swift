//
//  PokemonViewController.swift
//  pokedex
//
//  Created by Patrick Zhu on 9/26/20.
//  Copyright © 2020 Patrick Zhu. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    let dataSource: [Pokemon] = PokemonGenerator.getPokemonArray()
    var filteredPokemon = [Pokemon]()
    var nameArray = [String]()
    var urlArray = [String]()
    var currIndex: Int = 0
    var inSearchMode = false
    var poke: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeCollectionView.delegate = self
        pokeCollectionView.dataSource = self
        searchBar.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = dataSource[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: self)
    }
    
    @IBAction func didTapSegment(segment: UISegmentedControl) {
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        createNameArray()
        createURLArray()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    
        
        currIndex = indexPath.row
        cell.pokemonNameLabel.text = nameArray[currIndex]
        cell.configurePFP(with: urlArray[currIndex])
        return cell
    }
    
    func createNameArray() -> Void {
        if inSearchMode {
            for filtPokemon in filteredPokemon {
                nameArray.append(String(filtPokemon.id) + ": " + filtPokemon.name)
            }
        } else {
            for pokemon in dataSource {
                nameArray.append(String(pokemon.id) + ": " + pokemon.name)
            }
        }
    }
    
    func createURLArray() -> Void {
        if inSearchMode {
            for filtPokemon in filteredPokemon {
                urlArray.append(filtPokemon.imageUrl)
            }
        } else {
        for pokemon in dataSource {
            urlArray.append(pokemon.imageUrl)
        }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            self.pokeCollectionView.reloadData()
        } else {
            inSearchMode = true
        }
        let lower = searchBar.text!.lowercased()
        filteredPokemon = dataSource.filter({$0.name.range(of: lower) != nil })
        self.pokeCollectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? PokemonDetailVC else { return }
        vc.pokemon = self.poke
    }
     
}

