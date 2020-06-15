//
//  DTWPokemonDetailViewController.m
//  Pokedex-Objc
//
//  Created by David Wright on 6/15/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "DTWPokemonDetailViewController.h"
#import "DTWPokemon.h"
#import "DTWPokemonDetail.h"

void *KVOContext = &KVOContext;

@interface DTWPokemonDetailViewController ()

@property (nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *idLabel;
@property (nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation DTWPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)updateDetailLabels
{
    if (self.pokemon.details) {
        self.nameLabel.text = self.pokemon.details.name;
        self.idLabel.text = self.pokemon.details.identifier.stringValue;
        self.abilitiesLabel.text = self.pokemon.details.abilities;
    }
}

- (void)updateImageView
{
    if (self.pokemon.sprite) {
        self.pokemonImageView.image = self.pokemon.sprite;
    }
}

- (void)setPokemon:(DTWPokemon *)pokemon
{
    if (pokemon != _pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"details" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"sprite" context:KVOContext];

        [self willChangeValueForKey:@"pokemon"];
        _pokemon = pokemon;
        [self didChangeValueForKey:@"pokemon"];
        
        [_pokemon addObserver:self forKeyPath:@"details" options:0 context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"sprite" options:0 context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"details"]) {
            [self updateDetailLabels];
        } else if ([keyPath isEqualToString:@"sprite"]) {
            [self updateImageView];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    self.pokemon = nil;
}

@end
