//
//  PokeListTableViewController.h
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonController.h"

@class NetworkController;

NS_ASSUME_NONNULL_BEGIN

@interface PokeListTableViewController : UITableViewController

@property (nonatomic) NetworkController *networkController;

@end

NS_ASSUME_NONNULL_END
