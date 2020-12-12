//
//  PokedexTableVC.m
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import "PokedexTableVC.h"
#import "Pokedex-Swift.h"
#import "Pokemon.h"
#import "DetailVC.h"

@interface PokedexTableVC ()

@property (nonatomic) NSArray<Pokemon *> *pokemons;

@end

@implementation PokedexTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<Pokemon *> *pokemonArray, NSError *error) {
        if (error) {
            NSLog(@"Error fetching pokemon list: %@", error);
        }
        self.pokemons = pokemonArray;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    cell.textLabel.text = _pokemons[indexPath.row].name;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        DetailVC *detailVC = (DetailVC *)segue.destinationViewController;
        Pokemon *pokemon = [_pokemons objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailVC.pokemon = pokemon;
        [PokemonAPI.sharedController fillInDetailsFor:pokemon];
    }
}

@end
