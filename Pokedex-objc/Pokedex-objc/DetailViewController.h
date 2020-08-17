//
//  DetailViewController.h
//  Pokedex-objc
//
//  Created by Matthew Martindale on 8/16/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex_objc-Swift.h"
#import "MKMPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, retain) MKMPokemonAPI *pokemonAPI;
@property (nonatomic, retain) MKMPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
