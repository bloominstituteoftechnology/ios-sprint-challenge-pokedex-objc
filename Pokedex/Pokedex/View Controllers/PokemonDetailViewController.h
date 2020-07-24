//
//  PokemonDetailViewController.h
//  Pokedex
//
//  Created by Vincent Hoang on 7/24/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@class PokemonDetailViewController;
@class PokemonController;

@interface PokemonDetailViewController : UIViewController

@property (nonatomic, nullable, weak) Pokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
