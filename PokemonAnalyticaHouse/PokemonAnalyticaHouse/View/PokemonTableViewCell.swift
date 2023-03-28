//
//  PokemonTableViewCell.swift
//  PokemonAnalyticaHouse
//
//  Created by BerkH on 27.03.2023.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
