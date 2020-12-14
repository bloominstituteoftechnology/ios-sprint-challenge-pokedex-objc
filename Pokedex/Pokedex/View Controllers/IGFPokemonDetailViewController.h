//
//  IGFPokemonDetailViewController.h
//  Pokedex
//
//  Created by Ian French on 12/12/20.
//

#import <UIKit/UIKit.h>

@class IGFPokemonController;
@class IGFPokemonModel;

@interface IGFPokemonDetailViewController : UIViewController

@property (nonatomic) IGFPokemonController *pokemonController;
@property (nonatomic) IGFPokemonModel *pokemon;

@end

