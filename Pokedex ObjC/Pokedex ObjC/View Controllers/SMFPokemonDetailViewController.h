//
//  SMFPokemonDetailViewController.h
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMFPokemon;
@class SMFPokemonController;

NS_ASSUME_NONNULL_BEGIN

@interface SMFPokemonDetailViewController : UIViewController

@property (nonatomic, nullable) SMFPokemon *pokemon;
@property (nullable) SMFPokemonController *pokemonController;

@end

NS_ASSUME_NONNULL_END
