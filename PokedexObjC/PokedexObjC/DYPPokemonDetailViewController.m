//
//  DYPPokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPPokemonDetailViewController.h"

@interface DYPPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DYPPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)updateViews
{
    if (self.pokemon) {
        
        [self.imageView setImage:self.pokemon.sprite];
        [self.nameLabel setText:self.pokemon.name];
        [self.idLabel setText:[self.pokemon.identifier stringValue]];
        [self.abilitiesTextView setText:self.pokemon.abilities];
        
    }
}

- (void)setPokemon:(DYPPokemon *)pokemon
{
    _pokemon = pokemon;
    [self updateViews];
}

@end
