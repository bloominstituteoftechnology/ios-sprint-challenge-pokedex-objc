//
//  JDBPokemonTableViewController.h
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PokemonAPI;

NS_ASSUME_NONNULL_BEGIN

@interface JDBPokemonTableViewController : UITableViewController

- (instancetype) initWithPokemonAPI:(PokemonAPI *)pokemonAPI;

@end

NS_ASSUME_NONNULL_END
