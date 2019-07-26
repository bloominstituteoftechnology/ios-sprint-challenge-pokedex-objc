//
//  JGPPokemonTableViewController.h
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGPPokemon;


NS_ASSUME_NONNULL_BEGIN
@interface JGPPokemonTableViewController : UITableViewController

@property (nonatomic, copy, nullable) NSArray<JGPPokemon *> *pokemons;

@end
NS_ASSUME_NONNULL_END
