//
//  EGCPokemonDetailViewController.h
//  Pokedex
//
//  Created by Enrique Gongora on 4/24/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGCPokedexTableViewController.h"
#import "EGCPokemonController.h"
#import "EGCPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface EGCPokemonDetailViewController : UIViewController

@property (nonatomic) EGCPokemonController *pokemonController;
@property (nonatomic) EGCPokemon *pokemon;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;


@end

NS_ASSUME_NONNULL_END
