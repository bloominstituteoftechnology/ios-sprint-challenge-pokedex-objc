//
//  BTPokemonListTableViewController.h
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import <UIKit/UIKit.h>

@class BTPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface BTPokemonListTableViewController : UITableViewController

@property (nonatomic) NSArray<BTPokemon *> *arrayOfPokemonNames;

@end

NS_ASSUME_NONNULL_END
