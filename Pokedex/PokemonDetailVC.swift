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
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!

    var pokemon: Pokemon!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized
        
        let img = UIImage(named: String(pokemon.pokedexID))
        
        mainImg.image = img
        currentEvoImg.image = img
        pokedexLbl.text = String(pokemon.pokedexID)
        
        pokemon.downloadPokemonDetails
        {
            //whatever we write will only be called after the network call is completed
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        attackLbl.text = pokemon.attack
        weightLbl.text = pokemon.weight
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvoID == ""
        {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        }
        else
        {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoID)
        }
        
        let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLvl)"
        evoLbl.text = str
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}
