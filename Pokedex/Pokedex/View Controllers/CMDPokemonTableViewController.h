//
//  CMDPokemonTableViewController.h
//  Pokedex
//
//  Created by Chris Dobek on 6/19/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMDPokemonDetailViewController;
@class PokemonAPI;

NS_ASSUME_NONNULL_BEGIN

@interface CMDPokemonTableViewController : UITableViewController

@property (strong, nonatomic) CMDPokemonDetailViewController *detailViewController;

@end

NS_ASSUME_NONNULL_END
