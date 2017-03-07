//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Johnny Nicholson on 3/7/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{
    @IBOutlet weak var nameLbl: UILabel!

    var pokemon: Pokemon!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
    }
}
