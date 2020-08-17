//
//  PokemonDetailViewController.h
//  PokedexObjC
//
//  Created by Sean Acres on 8/16/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMAPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetailViewController : UIViewController

@property (nonatomic) SMAPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
