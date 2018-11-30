//
//  IIIPokemonDetailViewController.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokemonDetailViewController.h"

@interface IIIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilitiesTextView;

@end

@implementation IIIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    if (!self.isViewLoaded) { return; }
    
    if (self.pokemon) {
//        self.title = self.pokemon.name;
//        self.pokemonImageView.image = self.pokemon.image;
//        self.pokemonNameLabel.text = self.pokemon.name;
//        self.pokemonIdLabel.text = self.pokemon.identifier;
//        self.pokemonAbilitiesTextView.text = self.pokemon.abilities;
    }
}

- (void)setPokemon:(IIIPokemon *)pokemon
{
    _pokemon = pokemon;
    [self updateViews];
}

@end
