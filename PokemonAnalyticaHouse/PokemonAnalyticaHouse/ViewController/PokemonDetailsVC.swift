//
//  PokemonDetailsVC.swift
//  PokemonAnalyticaHouse
//
//  Created by BerkH on 27.03.2023.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    var pokemon: Pokemon?
    
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon Details"
        if let pokemon = pokemon {
            pokemonNameLabel.text = pokemon.name.capitalized
            print(pokemon.name)
            
            if let url = URL(string: pokemon.sprites.front_default ?? "") {
                pokemonImageView.loadImage(from: url)
            }

            let abilityNames = pokemon.abilities.map { $0.ability.name.capitalized }.joined(separator: ", ")
            abilitiesLabel.text = "Abilities: \(abilityNames)"
            abilitiesLabel.customLabelFont(label: abilitiesLabel, text: abilitiesLabel.text!, start: 0, finish: 9, fontType: "Helvetica-Bold", size: 17.0)
            view.addSubview(abilitiesLabel)
        }

    }
    
}

