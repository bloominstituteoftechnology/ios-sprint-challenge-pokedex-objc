//
//  LSIPokedexTableViewController.m
//  PokedexObj-C
//
//  Created by James McDougall on 3/5/21.
//

#import "LSIPokedexTableViewController.h"

//MARK: - Interface -
@interface LSIPokedexTableViewController ()

    @property NSArray<LSIPokemon *> *pokemonArray;
    - (void)fetchPokemon;

@end


//MARK: - Implementation -
@implementation LSIPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPokemon];
}

- (void)fetchPokemon {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<LSIPokemon *> *_Nullable pokemonArray, NSError *_Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_pokemonArray = pokemonArray;
            [self.tableView reloadData];
        });
        
    }];
}

// Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pokemonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    LSIPokemon *pokemon = self.pokemonArray[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

// Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PokemonDetailViewSegue"]) {
        
        LSIPokemonDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LSIPokemon *pokemon = self.pokemonArray[indexPath.row];
        detailVC.pokemon = pokemon;

    }
}

@end
