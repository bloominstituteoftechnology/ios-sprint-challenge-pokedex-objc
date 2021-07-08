//
//  LSIDetailViewController.h
//  Pokedex
//
//  Created by Alex on 7/26/19.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSIPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIDetailViewController : UIViewController

@property (nonatomic) LSIPokemon *pokemon;

- (void) updateViews;

@end

NS_ASSUME_NONNULL_END
