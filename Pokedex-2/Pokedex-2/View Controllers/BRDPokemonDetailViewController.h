//
//  BRDPokemonDetailViewController.h
//  Pokedex-2
//
//  Created by Bradley Diroff on 6/19/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex_2-Swift.h"
#import "BRDPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRDPokemonDetailViewController : UIViewController

@property (nonatomic, assign) PokemonAPI *pokemonController;
@property (nonatomic, assign) BRDPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
