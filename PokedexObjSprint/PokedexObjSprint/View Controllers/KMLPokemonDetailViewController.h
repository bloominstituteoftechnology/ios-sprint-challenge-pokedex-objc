//
//  KMLPokemonDetailViewController.h
//  PokedexObjSprint
//
//  Created by Keri Levesque on 4/24/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMLPokemonTableViewController.h"
#import "KMLPokemonController.h"
#import "KMLPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface KMLPokemonDetailViewController : UIViewController

@property (nonatomic) KMLPokemonController *pokemonController;
@property (nonatomic) KMLPokemon *pokemon;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;


@end

NS_ASSUME_NONNULL_END
