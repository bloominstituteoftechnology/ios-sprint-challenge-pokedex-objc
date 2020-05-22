//
//  WAHPokemonDetailsViewController.m
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import "WAHPokemonDetailsViewController.h"

@interface WAHPokemonDetailsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation WAHPokemonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"POKEMON: %@", self.pokemon.name);
    [self.pokemonController fillInDetailsFor:self.pokemon];
}



@end
