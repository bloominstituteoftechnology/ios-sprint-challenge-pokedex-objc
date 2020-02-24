//
//  PokemonDetailViewController.m
//  Pokedex-ObjC
//
//  Created by Fabiola S on 2/22/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokedex_ObjC-Swift.h"
#import "Pokemon.h"

void *KVOContext = &KVOContext;

@interface PokemonDetailViewController ()

@property (weak,nonatomic) IBOutlet UIImageView *pokemonImage;
@property (retain, nonatomic) IBOutlet UILabel *pokemonName;
@property (retain, nonatomic) IBOutlet UILabel *pokemonID;
@property (retain, nonatomic) IBOutlet UILabel *pokemonAbilities;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonController.sharedController fetchPokemonDetailsWithPokemon:self.pokemon];
}

- (void)updateViews
{
    if (!self.isViewLoaded || !self.pokemon) { return; }
    self.pokemonName.text = self.pokemon.name;
    self.pokemonID.text = [NSString stringWithFormat:@"ID: %d", self.pokemon.id];
    self.pokemonAbilities.text = [self.pokemon.abilities componentsJoinedByString:@", "];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.pokemon.sprites]];
    self.pokemonImage.image = [[UIImage alloc] initWithData:imageData];
}

- (void)setPokemon:(Pokemon *)pokemon
{
    if (_pokemon != pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"id" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"sprites" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
        
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"sprites" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end


