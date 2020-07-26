//
//  HMRDetailViewController.h
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMRPokemon.h"
#import "PokedexObjC-Swift.h"


NS_ASSUME_NONNULL_BEGIN

@interface HMRDetailViewController : NSObject

@property (nonatomic, assign) PokemonController *pokemonController;
@property (nonatomic, assign) HMRPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
