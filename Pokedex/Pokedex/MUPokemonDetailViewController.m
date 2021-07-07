//
//  MUPokemonDetailViewController.m
//  Pokedex
//
//  Created by Moin Uddin on 11/30/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

#import "MUPokemonDetailViewController.h"
#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface MUPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;

@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;

@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;

@end

@implementation MUPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    // Do any additional setup after loading the view.
}


- (void)updateViews
{
    NSString *name = [NSString stringWithFormat: @"Name: %@", self.pokemon.name];
    NSString *identifier = [NSString stringWithFormat: @"ID: %@", self.pokemon.identifier];
    [self.pokemonImageView setImage:self.pokemon.image];
    [self.pokemonNameLabel setText: name];
    [self.pokemonIdLabel setText: identifier];
    [self.pokemonAbilitiesLabel setText:[self.pokemon.abilities componentsJoinedByString:@", "]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPokemon:(MUPokemon *)pokemon
{
    if(pokemon != _pokemon) {
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}


@end
