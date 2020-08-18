//
//  PokemonTableViewController.h
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PokemonDetailViewController;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonTableViewController : UITableViewController

@property (strong, nonatomic) PokemonDetailViewController *detailViewController;

@end

NS_ASSUME_NONNULL_END
