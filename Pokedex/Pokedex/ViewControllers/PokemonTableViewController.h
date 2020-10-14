//
//  PokemonTableViewController.h
//  Pokedex
//
//  Created by Elizabeth Thomas on 10/13/20.
//

#import <UIKit/UIKit.h>

@class PokemonDetailViewController;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonTableViewController : UITableViewController

@property (strong, nonatomic) PokemonDetailViewController *detailViewController;

@end

NS_ASSUME_NONNULL_END
