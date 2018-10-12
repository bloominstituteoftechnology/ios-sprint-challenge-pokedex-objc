//
//  PokemonDetailViewController.m
//  Pokedex-objc
//
//  Created by Vuk Radosavljevic on 10/12/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokedex_objc-Swift.h"
#import "VUKPokemon.h"

@interface PokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

void *KVOContext = &KVOContext;

@implementation PokemonDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = self.pokemon.name;
    self.nameLabel.text = self.pokemon.name;
    PokemonController *pokemonController = [PokemonController shared];
    [pokemonController fillInDetailsFor:self.pokemon];
}


-(void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.identifierLabel.text = self.pokemon.identifier;
        self.abilitiesLabel.text = self.pokemon.abilities;
    });
    
}


- (void)setPokemon:(VUKPokemon *)pokemon
{
    if (!_pokemon) {
        _pokemon = pokemon;
        [_pokemon addObserver:self forKeyPath:@"sprite" options:0 context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context != KVOContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    
    [self updateViews];
    
}



@end
