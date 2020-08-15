//
//  ViewController.m
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "ViewController.h"
#import "Pokemon_Objc-Swift.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray<LSIPokemon *> *pokemonArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pokemonArray = [[NSMutableArray alloc] init];

    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<LSIPokemon *> *pokemonArray, NSError *error) {
        if (pokemonArray.count > 0) {
            self.pokemonArray = [pokemonArray mutableCopy];
            NSLog(@"Pokemon: %lu found", (unsigned long)self.pokemonArray.count);
        }
    }];
}

@end
