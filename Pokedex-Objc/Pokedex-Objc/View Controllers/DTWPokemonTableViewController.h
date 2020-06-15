//
//  DTWPokemonTableViewController.h
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTWPokemon;

@interface DTWPokemonTableViewController : UITableViewController

@property (nonatomic, copy, nonnull) NSArray<DTWPokemon *> *pokemon;

@end
