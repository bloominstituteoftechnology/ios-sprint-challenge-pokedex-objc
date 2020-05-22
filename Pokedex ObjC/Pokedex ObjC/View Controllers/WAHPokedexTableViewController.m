//
//  WAHPokedexTableViewController.m
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import "WAHPokedexTableViewController.h"
#import "Pokedex_ObjC-Swift.h"
#import "WAHPokemon.h"

@interface WAHPokedexTableViewController ()

@property (nonatomic) PokemonAPI *pokemonController;
@property (nonatomic, copy) NSArray<WAHPokemon *> *pokemon;

@end

@implementation WAHPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<WAHPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
    }];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    WAHPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

- (PokemonAPI *)pokemonController {
    if (!_pokemonController) {
        _pokemonController = [[PokemonAPI alloc] init];
    }
    return _pokemonController;
}


@end
