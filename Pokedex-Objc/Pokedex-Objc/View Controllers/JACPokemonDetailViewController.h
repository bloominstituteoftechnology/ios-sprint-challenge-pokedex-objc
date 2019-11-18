//
//  JACPokemonDetailViewController.h
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JACPokemon;
@class PokemonController;
NS_ASSUME_NONNULL_BEGIN

@interface JACPokemonDetailViewController : UIViewController
@property JACPokemon *pokemon;
@property PokemonController *controller;

@end

NS_ASSUME_NONNULL_END
