//
//  JLMPokemonDetailViewController.h
//  Pokedex
//
//  Created by Jason Modisett on 2/1/19.
//  Copyright © 2019 Jason Modisett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLMPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLMPokemonDetailViewController : UIViewController

-(void) updateViews;

@property (nonatomic) JLMPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
