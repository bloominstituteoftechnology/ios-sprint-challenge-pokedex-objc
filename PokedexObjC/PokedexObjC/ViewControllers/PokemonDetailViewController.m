//
//  PokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Carolyn Lea on 10/12/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import "PokemonDetailViewController.h"

@interface PokemonDetailViewController ()

@end

void *KVOContext = &KVOContext;

@implementation PokemonDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.nameLabel.text = self.pokemon.name;
    self.title = self.pokemon.name;
    
    [PokemonController.sharedController fillInDetailsFor:self.pokemon];
}


-(void)updateViews
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.idLabel.text = [NSString stringWithFormat: @"%ld", (long)self.pokemon.identifier];
        self.abilitiesLabel.text = [NSString stringWithFormat: @"%@", self.pokemon.abilities];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: self.pokemon.spriteURL];
        
        self.imageView.image = [UIImage imageWithData: imageData];
        
    });
}

- (void)setPokemon:(Pokemon *)pokemon
{
    if (pokemon != _pokemon)
    {
        
        [_pokemon removeObserver:self forKeyPath:@"sprite" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context != KVOContext)
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    
    [self updateViews];
    
}


@end
