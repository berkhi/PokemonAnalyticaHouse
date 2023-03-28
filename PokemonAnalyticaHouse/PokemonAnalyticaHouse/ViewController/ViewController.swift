//
//  ViewController.swift
//  PokemonAnalyticaHouse
//
//  Created by BerkH on 22.03.2023.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var PokemonTableViewCell: UITableView!
    
    
    var pokemons: [Pokemon] = []
    let api = PokemonAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemons"
        let pokemonAPI = PokemonAPI()
        let url = "https://pokeapi.co/api/v2/pokemon?limit=20"

        pokemonAPI.getData(from: url) { (pokemons, error) in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
            } else if let pokemons = pokemons {
                print("Toplam \(pokemons.count) adet pokemon verisi alındı:")
                self.pokemons = pokemons // Update the pokemons array here
                self.PokemonTableViewCell.reloadData() // Reload the table view to show the new data
            }
        }
        
        PokemonTableViewCell.delegate = self
        PokemonTableViewCell.dataSource = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPokemonDetail", let pokemon = sender as? Pokemon {
            let destination = segue.destination as! PokemonDetailsVC
            destination.pokemon = pokemon
        }
    }
}
    
    
    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemons.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
            
            let pokemon = pokemons[indexPath.row]
            let url = URL(string: pokemon.sprites.front_default!)!
            cell.pokemonNameLabel.text = pokemon.name.capitalized
            cell.pokemonNameLabel.customLabelFont(label: cell.pokemonNameLabel, text: cell.pokemonNameLabel.text!, start: 0, finish: (cell.pokemonNameLabel.text?.count)!, fontType: "Helvetica-Bold", size: 17)
            cell.pokemonImageView.loadImage(from: url)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let pokemon = pokemons[indexPath.row]
            performSegue(withIdentifier: "showPokemonDetail", sender: pokemon)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 100
        }

        
        
    }

