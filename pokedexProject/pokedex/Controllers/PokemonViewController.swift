//
//  PokemonViewController.swift
//  pokedex
//
//  Created by Patrick Zhu on 9/26/20.
//  Copyright © 2020 Patrick Zhu. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

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
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = dataSource[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailVC", sender: self)
    }
    
//    @IBAction func didTapSegment(segment: UISegmentedControl) {
//        return
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let currPoke: Pokemon!
        if inSearchMode {
            currPoke = filteredPokemon[indexPath.row]
        } else {
            currPoke = dataSource[indexPath.row]
        }
        cell.pokemonNameLabel.text = String(currPoke.id) + ": " + currPoke.name
        cell.configurePFP(with: currPoke.imageUrl)
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            pokeCollectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
        }
        let lower = searchBar.text!.lowercased()
        filteredPokemon = dataSource.filter({$0.name.range(of: lower) != nil})
        pokeCollectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? PokemonDetailVC else { return }
        vc.pokemon = self.poke
    }
     
}

