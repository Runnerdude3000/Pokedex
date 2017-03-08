//
//  Pokemon.swift
//  Pokedex
//
//  Created by Johnny Nicholson on 3/7/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _nextEvoLvl: String!
    
    var nextEvoName: String
    {
        if _nextEvoName == nil
        {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoID: String
    {
        if _nextEvoID == nil
        {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvoLvl: String
    {
        if _nextEvoLvl == nil
        {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    var name: String
    {
        return _name
    }
    
    var pokedexID: Int
    {
        return _pokedexID
    }
    
    var pokemonURL: String
    {
        if _pokemonURL == nil
        {
            _pokemonURL = ""
        }
        return _pokemonURL
    }
    
    var nextEvolutionTxt: String
    {
        if _nextEvolutionTxt == nil
        {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var attack: String
    {
        if _attack == nil
        {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String
    {
        if _weight == nil
        {
            _weight = ""
        }
        return _weight
    }
    
    var height: String
    {
        if _height == nil
        {
            _height = ""
        }
        return _height
    }
    
    var defense: String
    {
        if _defense == nil
        {
            _defense = ""
        }
        return _defense
    }
    
    var type: String
    {
        if _type == nil
        {
            _type = ""
        }
        return _type
    }
    
    var description: String
    {
        if _description == nil
        {
            _description = ""
        }
        return _description
    }
    
    init(name: String, pokedexID: Int)
    {
        self._name = name
        self._pokedexID = pokedexID
        self._pokemonURL = String(URL_BASE) + String(URL_POKEMON) + String(self._pokedexID)
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete)
    {
        Alamofire.request(_pokemonURL).responseJSON
        {
            (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String
                {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int
                {
                    self._attack = String(attack)
                }
                
                if let defense = dict["defense"] as? Int
                {
                    self._defense = String(defense)
                }
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>], types.count > 0
                {
                    if let name = types[0]["name"]
                    {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1
                    {
                        for x in 1..<types.count
                        {
                            if let name = types[x]["name"] as? String
                            {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                else
                {
                    self._type = ""
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>], descriptions.count > 0
                {
                    if let url = descriptions[0]["resource_uri"]
                    {
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON
                        {
                            (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject>
                            {
                                if let description = descDict["description"] as? String
                                {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                    //print(newDescription)
                                }
                            }
                            completed()
                        }
                    }
                }
                else
                {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0
                {
                    if let nextEvolution = evolutions[0]["to"] as? String
                    {
                        if nextEvolution.range(of: "mega") == nil
                        {
                            self._nextEvoName = nextEvolution
                            
                            if let uri = evolutions[0]["resource_uri"] as? String
                            {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newString.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"]
                                {
                                    if let lvl = lvlExist as? Int
                                    {
                                        self._nextEvoLvl = String(lvl)
                                    }
                                }
                                else
                                {
                                    self._nextEvoLvl = ""
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}


