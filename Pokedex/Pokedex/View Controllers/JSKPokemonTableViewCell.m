//
//  JSKPokemonTableViewCell.m
//  Pokedex
//
//  Created by Josh Kocsis on 10/9/20.
//

#import "JSKPokemonTableViewCell.h"
#import "JSKPokemon.h"
#import "Pokedex-Swift.h"

@interface JSKPokemonTableViewCell ()

@end

@implementation JSKPokemonTableViewCell


- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        _pokemon = [[JSKPokemon alloc] init];
        _pokemonController = [[PokemonNetwork alloc] init];
    }
    return self;
}

- (void)configureViews
{
    self.pokeName.text = self.pokemon.name;
}

- (void)setPokemon:(JSKPokemon *)pokemon
{
    _pokemon = pokemon;
    [self configureViews];
}

@end
