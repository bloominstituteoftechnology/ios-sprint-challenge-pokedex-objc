//
//  MUPokemonDetailViewController.h
//  Pokedex
//
//  Created by Moin Uddin on 11/30/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface MUPokemonDetailViewController : UIViewController

-(void) updateViews;

@property (nonatomic) MUPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
