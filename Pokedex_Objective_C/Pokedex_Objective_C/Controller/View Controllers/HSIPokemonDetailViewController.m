//
//  HSIPokemonDetailViewController.m
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "HSIPokemonDetailViewController.h"
#import "HSIPokemon.h"
#import "Pokedex_Objective_C-Swift.h"

@interface HSIPokemonDetailViewController ()

@end

@implementation HSIPokemonDetailViewController

NetworkService *networkService;

PokemonController *pokemonController;


- (void)viewDidLoad {
    [super viewDidLoad];
    //init controller layer
    pokemonController = PokemonController.shared;
    networkService = [[NetworkService alloc] initWithDataLoader:NSURLSession.sharedSession];

    [networkService getAllPokemonWithCompletion:^() {
        NSLog(@"%lu", pokemonController.pokemon.count);
        [networkService getPokemonAbilitiesWithPokemon:pokemonController.pokemon[0] completion:^{
            NSLog(@"%@", pokemonController.pokemon[0].abilities);
        }];
    }];
}

@end
