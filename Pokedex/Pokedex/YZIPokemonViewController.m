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
    _pokeImage.layer.cornerRadius = 10;
    _pokeImage.clipsToBounds = YES ;
    _pokeImage.layer.borderWidth = 2.0 ;
    
    
}


-(void)updateViews
{
    NSString *name = [NSString stringWithFormat: @"name: %@", self.pokemon.name];
    NSString *identifier = [NSString stringWithFormat: @"id: %@", self.pokemon.identifier];
    NSString *abilities = [NSString stringWithFormat: @"abilities: %@", self.pokemon.abilities] ;
    [self.pokeImage setImage:self.pokemon.image];
    [self.nameLabel setText: name];
    [self.idLabel setText: identifier];
    [self.abilitiesLabel setText: abilities.capitalizedString];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPokemon:(YZIPokedex *)pokemon
{
    if(pokemon != _pokemon) {
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}


- (void)dealloc;
{
    [self.pokemon removeObserver:self forKeyPath:@"abilities" context:&KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"id" context:&KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"image" context:&KVOContext];
}




@end
