//
//  HHPokemonDetailViewController.m
//  Pokedex
//
//  Created by Hayden Hastings on 7/26/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

#import "HHPokemonDetailViewController.h"
#import "HHPokemon.h"
#import "Pokedex-Swift.h"

@interface HHPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;

@end

@implementation HHPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pokemon.pokeName == nil) {
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:nil];
    }
    
    [PokemonController.pokeApi fillPokemonDetailsFor:self.pokemon];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateViews];
}

- (void)updateViews {
    if (self.isViewLoaded && self.pokemon) {
        self.title = [self.pokemon.pokeName capitalizedString];
        self.pokemonIDLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.pokeID];
        self.pokemonAbilitiesLabel.text = [[self.pokemon.pokeAbilities componentsJoinedByString:@", "] capitalizedString];
        
        NSURL *spriteURL = [NSURL URLWithString:self.pokemon.sprite];
        NSData *imageData = [NSData dataWithContentsOfURL:spriteURL];
        
        self.pokemonImageView.image = [UIImage imageWithData:imageData];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^ {
        [self updateViews];
    });
    
    [object removeObserver:self forKeyPath:keyPath];
}

@end
