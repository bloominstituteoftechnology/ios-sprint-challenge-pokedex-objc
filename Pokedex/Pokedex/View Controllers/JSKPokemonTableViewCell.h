//
//  JSKPokemonTableViewCell.h
//  Pokedex
//
//  Created by Josh Kocsis on 10/9/20.
//

#import <UIKit/UIKit.h>

@class PokemonNetwork;
@class JSKPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface JSKPokemonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *pokeName;
@property (nonatomic) JSKPokemon *pokemon;
@property (nonatomic) PokemonNetwork *pokemonController;

@end

NS_ASSUME_NONNULL_END
