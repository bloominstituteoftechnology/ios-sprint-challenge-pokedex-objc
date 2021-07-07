//
//  IIIPokemonDetailViewController.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokemonDetailViewController.h"
#import "IIIPokemon.h"

void *pokemonContext = &pokemonContext;

@interface IIIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilitiesTextView;

@end

@implementation IIIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonController.sharedController fillInDetailsFor:self.pokemon];
    [self updateViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateViewsAfterFetch];
}

- (void)dealloc
{
    self.pokemon = nil;
}

- (void)updateViews
{
    if (self.isViewLoaded && self.pokemon) {
        self.title = [self.pokemon.pokemonName capitalizedString];
        self.pokemonNameLabel.text = [self.pokemon.pokemonName capitalizedString];
        self.pokemonIdLabel.text = @"Loading...";
        self.pokemonAbilitiesTextView.text = @"Loading...";
        self.pokemonImageView.image = [UIImage imageNamed:@"loading"];
    }
}

- (void)updateViewsAfterFetch
{
    self.pokemonNameLabel.text = [self.pokemon.pokemonName capitalizedString];
    self.pokemonIdLabel.text = [self.pokemon.pokemonID stringValue];
    self.pokemonAbilitiesTextView.text = [[self.pokemon.pokemonAbilities componentsJoinedByString:@"\n"] capitalizedString];
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.pokemon.pokemonFrontDefaultImageURL];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.pokemonImageView.image = [UIImage imageWithData:imageData];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == pokemonContext) {
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPokemon:(IIIPokemon *)pokemon
{
    if (_pokemon != pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"pokemonID" context:pokemonContext];
        [_pokemon removeObserver:self forKeyPath:@"pokemonAbilities" context:pokemonContext];
        [_pokemon removeObserver:self forKeyPath:@"pokemonFrontDefaultImageURL" context:pokemonContext];

        _pokemon = pokemon;
        [self updateViews];
        
        [_pokemon addObserver:self forKeyPath:@"pokemonID" options:NSKeyValueObservingOptionInitial context:pokemonContext];
        [_pokemon addObserver:self forKeyPath:@"pokemonAbilities" options:NSKeyValueObservingOptionInitial context:pokemonContext];
        [_pokemon addObserver:self forKeyPath:@"pokemonFrontDefaultImageURL" options:NSKeyValueObservingOptionInitial context:pokemonContext];
    }
}

@end
