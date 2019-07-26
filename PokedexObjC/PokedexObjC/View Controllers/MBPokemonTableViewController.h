//
//  MBPokemonTableViewController.h
//  PokedexObjC
//
//  Created by Mitchell Budge on 7/26/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBPokemon.h"
#import "MBPokemonDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBPokemonTableViewController : UITableViewController

@property (nonatomic) NSArray<MBPokemon *> *allPokemon;

@end

NS_ASSUME_NONNULL_END
