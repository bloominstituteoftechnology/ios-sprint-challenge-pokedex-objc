//
//  KRHPokemonListTableViewController.h
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRHPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface KRHPokemonListTableViewController : UITableViewController

@property (nonatomic) NSArray<KRHPokemon *> *arrayOfPokemonNames;

@end

NS_ASSUME_NONNULL_END
