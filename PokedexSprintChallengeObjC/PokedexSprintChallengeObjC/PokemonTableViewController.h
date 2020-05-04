//
//  PokemonTableViewController.h
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokedexSprintChallengeObjC-Swift.h"

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonTableViewController : UITableViewController

@property (nonatomic) PokemonController *controller;
@property (nonatomic, copy) NSMutableArray<Pokemon *> *allPokemon;

@end

NS_ASSUME_NONNULL_END
