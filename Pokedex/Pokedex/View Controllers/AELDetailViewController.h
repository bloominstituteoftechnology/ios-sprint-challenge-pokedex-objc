//
//  DetailViewController.h
//  Pokedex
//
//  Created by Andrew Dhan on 10/12/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AELPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface AELDetailViewController : UIViewController

@property (nullable) AELPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
