//
//  DetailsViewController.m
//  Dex
//
//  Created by Ezra Black on 6/19/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

#import "DetailsViewController.h"
#import "CNSPokemon.h"
#import "Dex-Swift.h"


void *KVOContext = &KVOContext;

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonId;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilities;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CNSPokemonController.sharedController GETPokemonWithPokemon: self.pokemon];
}

- (void)updateViews
{
    if (!self.pokemon || self.isViewLoaded) { return; }
    self.pokemonName.text = self.pokemon.name;
    self.pokemonId.text = [NSString stringWithFormat:@"%d", self.pokemon.id];
    self.pokemonAbilities.text = [self.pokemon.abilities componentsJoinedByString:@", "];
    NSData *image = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.pokemon.sprites]];
    self.pokemonImage.image = [[UIImage alloc] initWithData:image];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                        context:(void *)context
{
    if (context == KVOContext)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [self updateViews];
        });
    } else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPokemon:(CNSPokemon *)pokemon
{
    if (_pokemon != pokemon)
    {
        [_pokemon removeObserver:self
                      forKeyPath:@"name"
                         context:KVOContext];
        [_pokemon removeObserver:self
                      forKeyPath:@"id"
                         context:KVOContext];
        [_pokemon removeObserver:self
                      forKeyPath:@"abilities"
                         context:KVOContext];
        [_pokemon removeObserver:self
                      forKeyPath:@"sprites"
                         context:KVOContext];
        _pokemon = pokemon;
        [_pokemon addObserver:self
                   forKeyPath:@"name"
                      options:NSKeyValueObservingOptionInitial
                      context:KVOContext];
        [_pokemon addObserver:self
                   forKeyPath:@"id"
                      options:NSKeyValueObservingOptionInitial
                      context:KVOContext];
        [_pokemon addObserver:self
                   forKeyPath:@"abilities"
                      options:NSKeyValueObservingOptionInitial
                      context:KVOContext];
        [_pokemon addObserver:self
                   forKeyPath:@"sprites"
                      options:NSKeyValueObservingOptionInitial
                      context:KVOContext];
    }
}

@end
