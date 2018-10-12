//
//  DODPokemonDetailViewController.m
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODPokemonDetailViewController.h"
#import "DODPokemon.h"

@interface DODPokemonDetailViewController ()

@property (nonatomic, readonly) DODPokemon *pokemon;


@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;

@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *pokemonIDLabel;

@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;

@end

@implementation DODPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pokemonImageView.image = [UIImage imageWithData:_pokemon.image];
    self.pokemonNameLabel.text = _pokemon.name;
    self.pokemonIDLabel.text = _pokemon.identifier;
    self.pokemonAbilitiesLabel.text = _pokemon.abilities;
}

@end
