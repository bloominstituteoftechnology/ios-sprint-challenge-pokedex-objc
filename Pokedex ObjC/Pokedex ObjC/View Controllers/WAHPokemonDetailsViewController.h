//
//  WAHPokemonDetailsViewController.h
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex_ObjC-Swift.h"
#import "WAHPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface WAHPokemonDetailsViewController : UIViewController

@property (nonatomic, assign) PokemonAPI *pokemonController;
@property (nonatomic, assign) WAHPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
