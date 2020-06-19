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

- (void)viewDidLoad {
    [super viewDidLoad];
    networkService = [[NetworkService alloc] initWithDataLoader:NSURLSession.sharedSession];
    [networkService getAllPokemonWithCompletion:^(NSArray<HSIPokemon *> *pokemonArray) {
        NSLog(@"%@", pokemonArray);
    }];
}

@end
