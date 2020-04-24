//
//  PokemonDetailViewController.h
//  PokemonObjC
//
//  Created by Chris Gonzales on 4/24/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDGPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetailViewController : UIViewController

@property (nonatomic) CDGPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
