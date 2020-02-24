//
//  PokemonDetailViewController.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/24/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "PokemonDetailViewController.h"

@interface PokemonDetailViewController ()

//MARK: - Outlets
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation PokemonDetailViewController

//MARK: - Views

- (void)viewDidLoad {
    [super viewDidLoad];
}

//MARK: - Methods

- (void)updateViews
{
    if (!self.isViewLoaded || !self.pokemon) { return; }
    
    self.imageView.image = [[UIImage alloc] initWithContentsOfFile:self.pokemon.sprite];
    self.nameLabel.text = self.pokemon.name;
    self.idLabel.text = self.pokemon.id;
    self.abilitiesTextView.text = self.pokemon.abilities.description;
}

- (void)setPokemon:(PokemonDetail *)pokemon
{
    
}



@end
