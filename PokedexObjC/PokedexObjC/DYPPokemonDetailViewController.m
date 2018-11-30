//
//  DYPPokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPPokemonDetailViewController.h"

//void *KVOContext = &KVOContext;

@interface DYPPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DYPPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    if (self.pokemon) {
        
       // [self.imageView setImage:self.pokemon.sprite];
        NSString *name = self.pokemon.name;
        [self.nameLabel setText:name];
        NSString *identifer = [self.pokemon.identifier stringValue];
        [self.idLabel setText:identifer];
        NSString *abilities = self.pokemon.abilities;
        [self.abilitiesTextView setText:abilities];
        
    }
}

- (void)setPokemon:(DYPPokemon *)pokemon
{
    if (pokemon != _pokemon) {
    
        _pokemon = pokemon;
    
        [self updateViews];
    }
}

@end
