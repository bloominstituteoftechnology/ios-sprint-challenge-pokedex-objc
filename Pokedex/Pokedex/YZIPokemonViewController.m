//
//  PokemonViewController.m
//  Pokedex
//
//  Created by Yvette Zhukovsky on 2/1/19.
//  Copyright © 2019 Yvette Zhukovsky. All rights reserved.
//

#import "YZIPokemonViewController.h"
#import "Pokedex-Swift.h"
#import "YZIPokedex.h"


@interface YZIPokemonViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokeImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

void *KVOContext = &KVOContext;


@implementation YZIPokemonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokedexController fillInDetailsFor:_pokemon];
    
}

- (void)fetchingImage:(BOOL)pokeImage identifier:(BOOL)identifier abilities:(BOOL)abilities name:(BOOL)name
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (pokeImage == YES) {
            self.pokeImage.image = self.pokemon.image;
        }
        if (name == YES) {
            self.nameLabel.text = [NSString stringWithFormat:@"name: %@", self.pokemon.name];
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
    
    BOOL name = NO ;
    BOOL identifier = NO;
    BOOL pokeImage = NO;
    BOOL abilities = NO;
    
    if ([keyPath isEqualToString: @"name"]) {
        name = YES;
    }
    
    if ([keyPath isEqualToString: @"image"]) {
        pokeImage = YES;
    }
    if ([keyPath isEqualToString: @"identifier"]) {
        identifier = YES;
    }
    if ([keyPath isEqualToString: @"abilities"]) {
        abilities = YES;
    }
    
    [self fetchingImage:pokeImage identifier:identifier abilities:abilities name: name];
}

//add & remove Observers


- (void)dealloc
{
    [_pokemon removeObserver:self forKeyPath:@"name"];
    [_pokemon removeObserver:self forKeyPath:@"image"];
    [_pokemon removeObserver:self forKeyPath:@"identifier"];
    [_pokemon removeObserver:self forKeyPath:@"abilities"];
}

- (void)setPokemon:(YZIPokedex *)pokemon
{
    if (_pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name"];
        [_pokemon removeObserver:self forKeyPath:@"image"];
        [_pokemon removeObserver:self forKeyPath:@"identifier"];
        [_pokemon removeObserver:self forKeyPath:@"abilities"];
    }
    
    _pokemon = pokemon;
    [_pokemon addObserver:self forKeyPath:@"name" options:0 context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"image" options:0 context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
}



@end
