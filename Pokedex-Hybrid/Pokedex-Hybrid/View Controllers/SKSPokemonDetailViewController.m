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
    [self pokemonObservers];
    [self.pokemonController fetchDetailsWithPokemonAPIForPokemon:self.pokemon];
}

- (void)updateViews {
    if(self.pokemon) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = [NSString stringWithFormat:@"Name: %@",self.pokemon.name];
            self.idLabel.text = [NSString stringWithFormat:@"ID: %d", self.pokemon.pokemonId];
            NSString *abilityString = [[self.pokemon.abilities valueForKey:@"description"] componentsJoinedByString:@", "];
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilityString];
        });
    }
}

- (void)pokemonObservers {
    [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionNew context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"pokemonId" options:NSKeyValueObservingOptionNew context:KVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        } else if([keyPath isEqualToString:@"pokemonId"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
