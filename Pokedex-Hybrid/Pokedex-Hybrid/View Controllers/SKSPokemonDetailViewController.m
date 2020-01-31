//
//  SKSPokemonDetailViewController.m
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSPokemonDetailViewController.h"
#import "SKSPokemonController.h"
#import "SKSPokemon.h"

void *KVOContext = &KVOContext;

@interface SKSPokemonDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *abilitiesLabel;

@end

@implementation SKSPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemonController fetchDetailsWithPokemonAPIForPokemon:self.pokemon];
}

- (void)updateViews {
    if(self.pokemon) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = [NSString stringWithFormat:@"Name: %@",self.pokemon.name];
            self.idLabel.text = [NSString stringWithFormat:@"ID: %d", self.pokemon.pokemonId];
            self.imageView.image = self.pokemon.pokemonSprite;
            NSString *abilityString = [[self.pokemon.abilities valueForKey:@"description"] componentsJoinedByString:@", "];
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilityString];
        });
    }
}

- (void)setPokemon:(SKSPokemon *)pokemon {

    [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
    [_pokemon removeObserver:self forKeyPath:@"pokemonId" context:KVOContext];
    [_pokemon removeObserver:self forKeyPath:@"pokemonSprite" context:KVOContext];

    _pokemon = pokemon;

    [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionNew context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"pokemonId" options:NSKeyValueObservingOptionNew context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"pokemonSprite" options:NSKeyValueObservingOptionNew context:KVOContext];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        } else if([keyPath isEqualToString:@"pokemonId"]) {
            [self updateViews];
        } else if([keyPath isEqualToString:@"pokemonSprite"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    self.pokemon = nil;
}

@end
