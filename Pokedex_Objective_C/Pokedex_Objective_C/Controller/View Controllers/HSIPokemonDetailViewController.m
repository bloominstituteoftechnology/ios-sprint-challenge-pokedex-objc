//
//  HSIPokemonDetailViewController.m
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "HSIPokemonDetailViewController.h"
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
    }];
}

@end
