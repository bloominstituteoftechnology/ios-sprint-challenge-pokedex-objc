//
//  SMFPokemonDetailViewController.m
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

#import "SMFPokemonDetailViewController.h"
#import "SMFPokemon.h"
#import "Pokedex_ObjC-Swift.h"

@interface SMFPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

void *KVOContext = &KVOContext;

@implementation SMFPokemonDetailViewController

- (void)setPokemon:(SMFPokemon *)pokemon
{
    if (_pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"image"];
        [_pokemon removeObserver:self forKeyPath:@"identifier"];
        [_pokemon removeObserver:self forKeyPath:@"abilities"];
    }
    
    _pokemon = pokemon;
    
    [_pokemon addObserver:self forKeyPath:@"image" options:0 context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
    
    [self.pokemonController fillInDetailsFor:_pokemon];
}

- (void)updateViewForImg:(BOOL)img identifier:(BOOL)identifier abilities:(BOOL)abilities
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (img == YES) {
            self.pokemonImg.image = self.pokemon.image;
        }
        if (identifier == YES) {
            self.idLabel.text = [NSString stringWithFormat:@"Id: %@", self.pokemon.identifier];
        }
        if (abilities == YES) {
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", self.pokemon.abilities];
        }
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context != KVOContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    BOOL img = NO;
    BOOL identifier = NO;
    BOOL abilities = NO;
    
    if ([keyPath isEqualToString: @"image"]) {
        img = YES;
    }
    if ([keyPath isEqualToString: @"identifier"]) {
        identifier = YES;
    }
    if ([keyPath isEqualToString: @"abilities"]) {
        abilities = YES;
    }
    
    [self updateViewForImg:img identifier:identifier abilities:abilities];
}

@end
