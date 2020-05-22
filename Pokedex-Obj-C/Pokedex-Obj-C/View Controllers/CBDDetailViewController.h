//
//  CBDDetailViewController.h
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@class CBDPokemon;
@class CBDPokemonShort;
@class NetworkController;

NS_ASSUME_NONNULL_BEGIN

@interface CBDDetailViewController : UIViewController

@property (nonatomic) NetworkController *networkController;
@property (nonatomic) CBDPokemonShort *pokemonShort;
@property (nonatomic) CBDPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
