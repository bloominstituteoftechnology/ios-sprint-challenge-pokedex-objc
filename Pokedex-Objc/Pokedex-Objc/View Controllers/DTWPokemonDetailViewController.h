//
//  DTWPokemonDetailViewController.h
//  Pokedex-Objc
//
//  Created by David Wright on 6/15/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTWPokemonDetail;
@class DTWPokemon;

@interface DTWPokemonDetailViewController : UIViewController

@property (nonatomic, nullable) DTWPokemon *pokemon;
@property (nonatomic, nullable) DTWPokemonDetail *pokemonDetail;
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, nullable) NSURL *detailsURL;

@end
