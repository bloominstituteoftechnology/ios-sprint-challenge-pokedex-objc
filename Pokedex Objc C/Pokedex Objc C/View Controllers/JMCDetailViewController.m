//
//  JMCDetailViewController.m
//  Pokedex Objc C
//
//  Created by Jarren Campos on 8/14/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

#import "JMCDetailViewController.h"
#import "Pokedex_Objc_C-Swift.h"
#import "JMCPokemon.h"

void *KVOContext = &KVOContext;

@interface JMCDetailViewController()

@property (weak,nonatomic) IBOutlet UIImageView *pokemonImage;
@property (retain, nonatomic) IBOutlet UILabel *pokemonName;
@property (retain, nonatomic) IBOutlet UILabel *pokemonID;
@property (retain, nonatomic) IBOutlet UILabel *pokemonAbilities;
@property (retain, nonatomic) IBOutlet UILabel *pokemonType;


@end

@implementation JMCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonController.sharedController fetchPokemonDetailsWithPokemon:self.pokemon];
}

- (void)updateViews
{
    if (!self.isViewLoaded || !self.pokemon) { return; }
    self.pokemonName.text = self.pokemon.name;
    self.pokemonID.text = [NSString stringWithFormat:@"%d", self.pokemon.id];
    self.pokemonAbilities.text = [self.pokemon.abilities componentsJoinedByString:@", "];
    self.pokemonType.text = [self.pokemon.type componentsJoinedByString:@", "];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.pokemon.sprite]];
    self.pokemonImage.image = [[UIImage alloc] initWithData:imageData];
        
}

- (void)setPokemon:(JMCPokemon *)pokemon
{
    if (_pokemon != pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"id" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"sprites" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"type" context:KVOContext];
        
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"sprites" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"type" options:NSKeyValueObservingOptionInitial context:KVOContext];
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



