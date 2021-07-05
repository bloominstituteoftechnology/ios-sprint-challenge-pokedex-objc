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
    _pokemonController = [[PokemonController alloc] init];
    [_pokemonController fillInDetailsFor:_pokemon from:self];
    
}

- (void)updateViews {
    _pokemonNameLabel.text = [_pokemon.name capitalizedString];
    _pokemonIDLabel.text = [_pokemon.idNumber stringValue];
    _pokemonAbilitiesLabel.text = @"Abilities:";
    switch (_pokemon.abililties.count) {
        case 0:
            break;
        case 1:
            _pokemonFirstAbilityLabel.text = _pokemon.abililties[0];
            break;
        case 2:
            _pokemonFirstAbilityLabel.text = _pokemon.abililties[0];
            _pokemonSecondAbilityLabel.text = _pokemon.abililties[1];
            break;
        case 3:
            _pokemonFirstAbilityLabel.text = _pokemon.abililties[0];
            _pokemonSecondAbilityLabel.text = _pokemon.abililties[1];
            _pokemonThirdAbilityLabel.text = _pokemon.abililties[2];
            break;
    }
    NSURL *url = [NSURL URLWithString:_pokemon.sprite];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _pokemonSpriteImageView.image = [UIImage imageWithData:data];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"Value changed.");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
}
@end
