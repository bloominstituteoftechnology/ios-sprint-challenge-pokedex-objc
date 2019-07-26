//
//  JGPPokemonTableViewController.h
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGPPokemon;



@interface JGPPokemonTableViewController : UITableViewController

@property (nonatomic, copy, nullable) NSArray<JGPPokemon *> *pokemons;

@end

