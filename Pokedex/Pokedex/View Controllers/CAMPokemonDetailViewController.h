//
//  CAMPokemonDetailViewController.h
//  Pokedex
//
//  Created by Cody Morley on 7/24/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface CAMPokemonDetailViewController : UIViewController

@property (nonatomic) int pokemonID;
@property (nonatomic) PokedexAPIController *pokedex;
@property (nonatomic) CAMPokemon *pokemon;



@end

NS_ASSUME_NONNULL_END
