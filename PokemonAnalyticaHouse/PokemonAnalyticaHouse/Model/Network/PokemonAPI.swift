//
//  Request.swift
//  PokemonAnalyticaHouse
//
//  Created by BerkH on 27.03.2023.
//

import Foundation

class PokemonAPI {
    
    func getData(from url: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
            var pokemons: [Pokemon] = []
            let group = DispatchGroup()
            
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }

                var result: Response?
                do {
                    result = try JSONDecoder().decode(Response.self, from: data)
                } catch {
                    completion(nil, error)
                    return
                }

                guard let json = result else {
                    completion(nil, NSError(domain: "ParsingError", code: 0, userInfo: nil))
                    return
                }

                print(json.count)
                for result in json.results {
                    if let url = URL(string: result.url) {
                        group.enter() // Enter the dispatch group
                        self.getPokemonDetails(from: url, completion: { (pokemon, error) in
                            defer {
                                group.leave() // Leave the dispatch group, no matter what
                            }
                            if let pokemon = pokemon {
                                pokemons.append(pokemon)
                            } else if let error = error {
                                completion(nil, error)
                                return
                            }
                        })
                    }
                }
                
                group.notify(queue: DispatchQueue.main) {
                    // All Pokemon data has been processed
                    completion(pokemons, nil)
                }
            })
            task.resume()
        }


    func getPokemonDetails(from url: URL, completion: @escaping (Pokemon?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }

            var pokemon: Pokemon?
            do {
                pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            } catch {
                completion(nil, error)
                return
            }

            guard let newPokemon = pokemon else {
                completion(nil, NSError(domain: "ParsingError", code: 0, userInfo: nil))
                return
            }

            DispatchQueue.main.async {
                completion(newPokemon, nil)
            }
        })
        task.resume()
    }
}



