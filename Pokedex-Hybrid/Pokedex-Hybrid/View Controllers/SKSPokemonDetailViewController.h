//
//  SKSPokemonDetailViewController.h
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKSPokemonController, SKSPokemon;

@interface SKSPokemonDetailViewController : UIViewController

@property (nonatomic) SKSPokemonController *pokemonController;
@property (nonatomic) SKSPokemon *pokemon;

@end

