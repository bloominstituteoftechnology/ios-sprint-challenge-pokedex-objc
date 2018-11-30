//
//  IIIPokemonDetailViewController.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokemonDetailViewController.h"
#import "IIIPokemon.h"

void *KVOContext = &KVOContext;

@interface IIIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilitiesTextView;

@end

@implementation IIIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    if (!self.isViewLoaded) { return; }
    
    if (self.pokemon) {
        self.title = self.pokemon.pokemonName;
        self.pokemonNameLabel.text = self.pokemon.pokemonName;
        
        if (self.pokemon.pokemonID) {
            self.pokemonIdLabel.text = [self.pokemon.pokemonID stringValue];
        } else {
            self.pokemonIdLabel.text = @"Loading";
        }
        
        if (self.pokemon.pokemonAbilities) {
            self.pokemonAbilitiesTextView.text = [self.pokemon.pokemonAbilities componentsJoinedByString:@", "];
        } else {
            self.pokemonAbilitiesTextView.text = @"Loading";
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        [self updateViews];
//        NSURL *url = [NSURL URLWithString:self.pokemon.pokemonFrontDefaultImageURLString];
//        [PokemonController.sharedController fetchPokemonImageWithUrl:url completion:^(UIImage * image, NSError * error) {
//            self.pokemonImageView.image = image;
//        }];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPokemon:(IIIPokemon *)pokemon
{
    if (_pokemon != pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"pokemonID" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"pokemonAbilities" context:KVOContext];
        
        _pokemon = pokemon;
        [PokemonController.sharedController fillInDetailsFor:pokemon];
        [self updateViews];
        
        [_pokemon addObserver:self forKeyPath:@"pokemonID" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"pokemonAbilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

@end
