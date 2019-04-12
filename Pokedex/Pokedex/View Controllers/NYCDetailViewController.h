//
//  NYCDetailViewController.h
//  Pokedex
//
//  Created by Nathanael Youngren on 4/12/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYCPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface NYCDetailViewController : UIViewController

@property (nonatomic) NYCPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
