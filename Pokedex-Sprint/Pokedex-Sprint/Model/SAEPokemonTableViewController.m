//
//  SAEPokemonTableViewController.m
//  Pokedex-Sprint
//
//  Created by Sammy Alvarado on 12/14/20.
//

#import "SAEPokemonTableViewController.h"
#import "SAEPokemon.h"
//#import "Pokedex-Sprint-Bridging-Header.h"
#import "Pokedex_Sprint-Swift.h"


@class PokemonController;

@interface SAEPokemonTableViewController ()

@property (nonatomic) NSArray<SAEPokemon *> *pokemons;

@end

@implementation SAEPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.sharedController fetchPokemonsWithCompletion:^(NSArray<SAEPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching Pokemons: %@", error);
        }
        self.pokemons = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    SAEPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetialViewSegue"]) {
        PokemonDetailViewController *detailVC = (PokemonDetailViewController *)segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailVC.pokemon = self.pokemons[indexPath.row];
    }
}


@end
