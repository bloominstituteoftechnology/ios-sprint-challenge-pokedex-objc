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

- (void)viewDidLoad {
    [super viewDidLoad];
    //init controller
    networkService = [[NetworkService alloc] initWithDataLoader:NSURLSession.sharedSession];
    if (_pokemon) {
        [networkService getPokemonAbilitiesWithPokemon: self.pokemon completion:^{
            NSLog(@"%@", self.pokemon.abilities);
        }];
    }

}

@end
