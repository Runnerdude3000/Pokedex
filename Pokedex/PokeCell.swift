import UIKit

class PokeCell: UICollectionViewCell
{
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
        
    }
    
    func configureCell(_ pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: String(self.pokemon.pokedexID))
    }
}
