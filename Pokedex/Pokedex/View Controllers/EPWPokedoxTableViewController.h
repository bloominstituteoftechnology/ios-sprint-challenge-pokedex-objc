//
//  EPWPokedoxTableViewController.h
//  Pokedex
//
//  Created by Elizabeth Wingate on 4/24/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PokemonAPI;

@interface EPWPokedoxTableViewController : UITableViewController

@property (nonatomic) PokemonAPI *pokemonAPI;

@end

NS_ASSUME_NONNULL_END
