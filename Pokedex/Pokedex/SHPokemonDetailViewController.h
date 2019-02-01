//
//  SHPokemonDetailViewController.h
//  Pokedex
//
//  Created by Sean Hendrix on 2/1/19.
//  Copyright © 2019 Sean Hendrix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPokemonDetailViewController : UIViewController

-(void) updateViews;

@property (nonatomic) SHPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
