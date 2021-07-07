//
//  TXCPokemonTableViewController.h
//  PokedexObjc
//
//  Created by Thomas Cacciatore on 7/26/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXCPokemon;
NS_ASSUME_NONNULL_BEGIN

@interface TXCPokemonTableViewController : UITableViewController

@property (nonatomic, copy, nullable) NSArray<TXCPokemon *> *pokemons;

@end

NS_ASSUME_NONNULL_END
