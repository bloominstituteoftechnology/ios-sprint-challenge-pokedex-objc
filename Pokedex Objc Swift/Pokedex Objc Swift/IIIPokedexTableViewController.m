//
//  IIIPokedexTableViewController.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokedexTableViewController.h"
#import "IIIPokemonDetailViewController.h"
#import "IIIPokemon.h"

@interface IIIPokedexTableViewController ()

@end

@implementation IIIPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<IIIPokemon *> * pokemon, NSError * error) {
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return PokemonController.sharedController.pokedex.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    IIIPokemon *pokemon = PokemonController.sharedController.pokedex[indexPath.row];
    
    cell.textLabel.text = [pokemon.pokemonName capitalizedString];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CellSegue"]) {
        IIIPokemonDetailViewController *destVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        destVC.pokemon = PokemonController.sharedController.pokedex[indexPath.row];
    }
}

@end
