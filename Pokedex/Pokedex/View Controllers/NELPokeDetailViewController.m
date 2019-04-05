//
//  NELPokeDetailViewController.m
//  Pokedex
//
//  Created by Nelson Gonzalez on 4/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

#import "NELPokeDetailViewController.h"
#import "NELPokemon.h"
#import "Pokedex-Swift.h"

@interface NELPokeDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pokeImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokeIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokeAbilitiesLabel;

@end

@implementation NELPokeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pokemons.pokeName == nil) {
        [self.pokemons addObserver:self forKeyPath:@"abilities" options:0 context:nil];
    }
    
    [PokemonApi.pokeApi fillPokemonDetailsFor:self.pokemons];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [self updateViews];
}


- (void)updateViews
{

    if (self.isViewLoaded && self.pokemons) {
        self.title = [self.pokemons.pokeName capitalizedString];
        self.pokeNameLabel.text = [self.pokemons.pokeName capitalizedString];
        self.pokeIdLabel.text = [NSString stringWithFormat:@"%@", self.pokemons.pokeId];
        self.pokeAbilitiesLabel.text = [[self.pokemons.pokeAbilities componentsJoinedByString:@", "] capitalizedString];

        NSURL *spriteUrl = [NSURL URLWithString:self.pokemons.sprite];

        NSData *imageData = [NSData dataWithContentsOfURL:spriteUrl];

        self.pokeImageView.image = [UIImage imageWithData:imageData];
      

    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    dispatch_sync(dispatch_get_main_queue(), ^ {
        [self updateViews];
    });
    
    [object removeObserver:self forKeyPath:keyPath];
}


@end

