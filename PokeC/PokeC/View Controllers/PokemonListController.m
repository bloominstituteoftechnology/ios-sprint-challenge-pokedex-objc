//
//  PokemonListController.m
//  PokeC
//
//  Created by Lotanna Igwe-Odunze on 3/15/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

#import "PokemonListController.h"
#import "Pokemon.h"
#import "PokeC-Swift.h"
#import "PokemonViewController.h"

@interface PokemonListController ()

@property NSArray<Pokemon *> *pokedex;

@end

@implementation PokemonListController

#pragma mark - Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pokedex = [NSArray array];
    
    [PokemonImporter.shared grabPokemonWithCompletion:^(NSArray<Pokemon *> * _Nullable pokeList, NSError * _Nullable error) {
        self.pokedex = pokeList;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokedex.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokeCell" forIndexPath:indexPath];
    Pokemon *pokemon = self.pokedex[indexPath.row];
    
    [cell.textLabel setText:[pokemon.name capitalizedString]];
    
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PokemonViewController *destinationVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    Pokemon *pokemon = self.pokedex[indexPath.row];
    
    [PokemonImporter.shared grabPokemonInfoFor: pokemon];
    
    destinationVC.pokemon = pokemon;
}

@end
