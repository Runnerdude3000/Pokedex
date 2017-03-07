//
//  Pokemon.swift
//  Pokedex
//
//  Created by Johnny Nicholson on 3/7/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation

class Pokemon
{
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name: String
    {
        return _name
    }
    
    var pokedexID: Int
    {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int)
    {
        self._name = name
        self._pokedexID = pokedexID
    }
    
    
    
}










