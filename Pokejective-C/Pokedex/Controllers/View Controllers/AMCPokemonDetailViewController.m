//
//  AMCPokemonDetailViewController.m
//  Pokedex
//
//  Created by Aaron Cleveland on 3/27/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

#import "AMCPokemonDetailViewController.h"
#import "AMCPokemon.h"
#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface AMCPokemonDetailViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonId;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilities;

@end

@implementation AMCPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMCPokemonController.sharedController fillInPokemonDetailsWithPokemon:self.pokemon];
}

- (void)updateViews
{
    if (!self.isViewLoaded || !self.pokemon) { return; }
    
    self.pokemonName.text = self.pokemon.name;
    self.pokemonId.text = [NSString stringWithFormat:@"%d", self.pokemon.id];
    
    self.pokemonAbilities.text = [self.pokemon.abilities componentsJoinedByString:@", "];
    
    
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.pokemon.sprites]];
    self.pokemonImage.image = [[UIImage alloc] initWithData:imageData];
}

- (void)setPokemon:(AMCPokemon *)pokemon
{
    if (_pokemon != pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"id" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"sprites" context:KVOContext];
        
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"sprites" options:NSKeyValueObservingOptionInitial context:KVOContext];
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

