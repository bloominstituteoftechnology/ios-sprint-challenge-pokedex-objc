//
//  EPWDetailViewController.h
//  Pokedex
//
//  Created by Elizabeth Wingate on 4/24/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPWPokemon;
@class PokemonAPI;

NS_ASSUME_NONNULL_BEGIN

@interface EPWDetailViewController : UIViewController

@property (nonatomic,copy,nullable) EPWPokemon *pokemon;
@property (nonatomic) PokemonAPI *pokemonAPI;

@end

NS_ASSUME_NONNULL_END
