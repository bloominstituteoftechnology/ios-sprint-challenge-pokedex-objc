//
//  PokemonsTableViewController.m
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

#import "PokemonsTableViewController.h"
#import "LSIPokemon.h"
#import "ObjcPokeDex-Swift.h"

@interface PokemonsTableViewController ()

@property NSArray<LSIPokemon *> *pokemons;

@end

@implementation PokemonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PokemonAPI *pa = [PokemonAPI sharedController];
    [pa fetchAllPokemonWithCompletion:^(NSArray<LSIPokemon *> *allPokemons, NSError *error) {
        self.pokemons = allPokemons;
        dispatch_async(dispatch_get_main_queue(), ^{
                   [self.tableView reloadData];
               });
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    LSIPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPoke"]) {
           NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       PokemonDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = [self.pokemons objectAtIndex:indexPath.row];
       }
}


@end
