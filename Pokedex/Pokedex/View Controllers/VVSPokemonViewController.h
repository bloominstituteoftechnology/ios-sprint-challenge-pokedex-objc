//
//  VVSPokemonViewController.h
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVSPokedexTableViewController.h"
#import "VVSPokemonController.h"
#import "VVSPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVSPokemonViewController : UIViewController

@property (nonatomic) VVSPokemonController *pokemonController;
@property (nonatomic) VVSPokemon *pokemon;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

NS_ASSUME_NONNULL_END
