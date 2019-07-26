//
//  SLRDetailViewController.m
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

#import "SLRDetailViewController.h"
#import "SLRPokemon.h"
#import "Pokedex-Swift.h"


@interface SLRDetailViewController ()

@property PokemonAPI *apiDetailFetch;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation SLRDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.pokemon addObserver:self forKeyPath:@"sprite" options:0 context:NULL];
    _apiDetailFetch = [[PokemonAPI alloc] init];
    [self.apiDetailFetch fillInDetailsFor:self.pokemon];
}

- (void) displayDetail {
    if(![self.pokemon pokemonName] && ![self isViewLoaded]) {
        return;
    }
    
    // Display the detail
    [self setTitle:self.pokemon.pokemonName];
}



@end
