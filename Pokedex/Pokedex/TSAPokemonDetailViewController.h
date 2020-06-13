//
//  TSAPokemonDetailViewController.h
//  Pokedex
//
//  Created by Alex Thompson on 6/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex-Swift.h"
#import "TSAPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSAPokemonDetailViewController : UIViewController

@property (nonatomic, assign) TSAPokemonController *pokemonController;
@property (nonatomic, assign) TSAPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
