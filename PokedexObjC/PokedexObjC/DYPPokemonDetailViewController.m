//
//  DYPPokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPPokemonDetailViewController.h"

void *KVOContext = &KVOContext;

@interface DYPPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DYPPokemonDetailViewController

- (void)dealloc
{
    self.pokemon = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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
    if (pokemon != _pokemon) {
    
        [_pokemon removeObserver:self forKeyPath:@"sprite" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
    
        _pokemon = pokemon;
    
        [_pokemon addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

@end
