//
//  LSIPokemonDetailViewController.h
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSIPokemon;
@class PokemonAPI;

NS_ASSUME_NONNULL_BEGIN

@interface LSIPokemonDetailViewController : UIViewController

@property (nonatomic, copy, nullable) LSIPokemon *pokemon;
@property (nonatomic) PokemonAPI *pokemonAPI;

@end

NS_ASSUME_NONNULL_END
