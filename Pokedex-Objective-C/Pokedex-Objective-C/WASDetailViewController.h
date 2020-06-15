//
//  WASDetailViewController.h
//  Pokedex-Objective-C
//
//  Created by Alex Shillingford on 6/14/20.
//  Copyright © 2020 shillwil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WASPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface WASDetailViewController : UIViewController

@property (nonatomic) WASPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
