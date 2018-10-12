//
//  PokemonDetailViewController.h
//  Pokedex-objc
//
//  Created by Vuk Radosavljevic on 10/12/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex_objc-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@class VUKPokemon;
@class PokemonController;

@interface PokemonDetailViewController : UIViewController

@property (nonatomic, nullable) VUKPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
