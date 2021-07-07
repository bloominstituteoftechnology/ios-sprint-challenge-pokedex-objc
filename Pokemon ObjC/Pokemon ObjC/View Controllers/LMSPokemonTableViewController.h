//
//  LMSPokemonTableViewController.h
//  Pokemon ObjC
//
//  Created by Lisa Sampson on 3/8/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMSPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMSPokemonTableViewController : UITableViewController

@property NSArray <LMSPokemon *> *pokemon;

@end

NS_ASSUME_NONNULL_END
