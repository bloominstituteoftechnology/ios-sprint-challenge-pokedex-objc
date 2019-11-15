//
//  JDSPokedexTableViewController.m
//  Pokedex_ObjC
//
//  Created by Lambda_School_Loaner_214 on 11/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JDSPokedexTableViewController.h"
#import "Pokedex_ObjC-Swift.h"

@interface JDSPokedexTableViewController ()
@property (nonatomic) NSArray<JDSPokemon *> *pokemonList;
@end

@implementation JDSPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[JDSPokemonController sharedController] fetchAllPokemonWithCompletion:^(NSArray<JDSPokemon *> *allPokemon, NSError * error) {
        self.pokemonList = [allPokemon sortedArrayUsingSelector:(@selector(compare:))];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pokemonList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    JDSPokemon *pokemon = self.pokemonList[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonSegue"]) {
        JDSPokemonDetailViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JDSPokemon *pokemon = self.pokemonList[indexPath.row];
        vc.pokemon = pokemon;
        [[JDSPokemonController sharedController] fillInDetailsFor:pokemon];
    }
}
@end
