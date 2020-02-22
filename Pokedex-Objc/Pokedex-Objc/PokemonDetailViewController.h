//
//  PokemonDetailViewController.h
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Pokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetailViewController : UIViewController

@property (nonatomic) Pokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
