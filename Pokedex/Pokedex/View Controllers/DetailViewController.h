//
//  DetailViewController.h
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@class MBMPokemon;
@class MBMSelectedPokemon;

@interface DetailViewController : UIViewController

@property (nonatomic) PokemonAPI *pokemonAPI;
@property (nonatomic) MBMPokemon *aPokemon;
@property (nonatomic) MBMSelectedPokemon *selectedPokemon;

@end

NS_ASSUME_NONNULL_END
