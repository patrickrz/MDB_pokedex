//
//  FilterViewController.swift
//  pokedex
//
//  Created by Patrick Zhu on 10/5/20.
//  Copyright © 2020 Patrick Zhu. All rights reserved.
//

import UIKit


//this class only passes information back!!!
class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var pokemonArray = [Pokemon]()
    
    @IBOutlet weak var filterTypesCollectionView: UICollectionView!
    var pvc: PokemonViewController!
    var possibleTypes = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water", "Unknown"]
    var selectedTypes = [String]()
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var minAttackPointsLabel: UILabel!
    @IBOutlet weak var atkSlider: UISlider!
    @IBOutlet weak var minDefensePointsLabel: UILabel!
    @IBOutlet weak var defSlider: UISlider!
    @IBOutlet weak var minHealthPointsLabel: UILabel!
    @IBOutlet weak var healthSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atkSlider.maximumValue = 200.0
        defSlider.maximumValue = 100.0
        healthSlider.maximumValue = 100.0
        filterTypesCollectionView.delegate = self
        filterTypesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedString = indexPath.row
        if selectedTypes.contains(possibleTypes[selectedString]) {
            selectedTypes = selectedTypes.filter(){$0 != possibleTypes[selectedString]}
        } else {
            selectedTypes.append(possibleTypes[indexPath.row])
        }
        print(selectedTypes)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return possibleTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterTypeCollectionViewCell
        let currType: String!
        currType = possibleTypes[indexPath.row]
        cell.filterNameLabel.text = currType
        return cell
    }
    

    @IBAction func doneButtonAction(_ sender: Any) {
       // pvc.filterFromFilters(minAtk: Int(atkSlider!.value), minDef: Int(defSlider!.value), minHP: Int(healthSlider!.value), typesArray: selectedTypes)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
