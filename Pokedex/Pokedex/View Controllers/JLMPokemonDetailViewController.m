//
//  JLMPokemonDetailViewController.m
//  Pokedex
//
//  Created by Jason Modisett on 2/1/19.
//  Copyright © 2019 Jason Modisett. All rights reserved.
//

#import "JLMPokemonDetailViewController.h"
#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface JLMPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;

@end

@implementation JLMPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController fillInDetailsFor: self.pokemon];
}


- (void)updateViews
{
    NSString *name = [self.pokemon.name capitalizedString];
    NSString *identifier = [self.pokemon identifier];
    NSString *abilities = [self.pokemon.abilities componentsJoinedByString:@", "];
    [self.pokemonImageView setImage:self.pokemon.image];
    [self.pokemonNameLabel setText: name];
    [self.pokemonIdLabel setText: identifier];
    [self.pokemonAbilitiesLabel setText: [abilities capitalizedString]];
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

- (void)setPokemon:(JLMPokemon *)pokemon
{
    if(pokemon != _pokemon) {
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}


@end
