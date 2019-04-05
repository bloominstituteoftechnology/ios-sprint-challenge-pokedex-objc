//
//  NELPokeTableViewController.m
//  Pokedex
//
//  Created by Nelson Gonzalez on 4/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

#import "NELPokeTableViewController.h"
#import "NELPokemon.h"
#import "NELPokeDetailViewController.h"
#import "Pokedex-Swift.h"


@interface NELPokeTableViewController ()

@property (nonatomic, strong) NSArray<NELPokemon *> *allPokemons;
@property (nonatomic, readonly) PokemonApi *pokemonController;

@end

@implementation NELPokeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonController = [PokemonApi pokeApi];
    
    [_pokemonController fetchPokemonsWithCompletion:^(NSArray<NELPokemon *> *allPokemons, NSError *error) {
        if (error) {
            NSLog(@"Error fetching all pokemons");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.allPokemons = allPokemons;
            [self.tableView reloadData];
        });
    }];
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allPokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokeCell" forIndexPath:indexPath];
    
    NELPokemon *pokemons = self.allPokemons[indexPath.row];
    
    cell.textLabel.text = pokemons.pokeName;
        
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}


@end
