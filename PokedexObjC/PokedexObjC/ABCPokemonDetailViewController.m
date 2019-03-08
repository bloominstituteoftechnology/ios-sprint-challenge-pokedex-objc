//
//  ABCPokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import "ABCPokemonDetailViewController.h"
#import "PokedexObjC-Swift.h"

@interface ABCPokemonDetailViewController ()

@property PokemonController *pokemonController;

@end

@implementation ABCPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startMonitoringPokemon:_pokemon];
    _pokemonController = [[PokemonController alloc] init];
    [_pokemonController fillInDetailsFor:_pokemon];
    [self updateViews];
    
}

- (void)updateViews {
    _pokemonNameLabel.text = [_pokemon.name capitalizedString];
    _pokemonIDLabel.text = _pokemon.idNumber;
    _pokemonAbilitiesLabel.text = @"Abilities:";
    _pokemonFirstAbilityLabel.text = _pokemon.abililties[0];
    _pokemonSecondAbilityLabel.text = _pokemon.abililties[1];
    _pokemonThirdAbilityLabel.text = _pokemon.abililties[2];
    NSURL *url = [NSURL URLWithString:_pokemon.sprite];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _pokemonSpriteImageView.image = [UIImage imageWithData:data];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"Value changed.");
    [self updateViews];
}

- (void)startMonitoringPokemon: (ABCPokemon *)pokemon {
    [pokemon addObserver:self forKeyPath:@"abilities" options:0 context:NULL];
}
@end
