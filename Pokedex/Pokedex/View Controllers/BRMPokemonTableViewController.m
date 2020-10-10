//
//  BRMPokemonTableViewController.m
//  Pokedex
//
//  Created by Bronson Mullens on 10/9/20.
//

#import "BRMPokemonTableViewController.h"
#import "BRMPokemon.h"
#import "Pokedex-Swift.h"

@interface BRMPokemonTableViewController ()

@property NSArray<BRMPokemon *> *pokedex;

@end

@implementation BRMPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPokedex];
}

// MARK: - Methods

- (void)loadPokedex {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<BRMPokemon *> *pokemonNames, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokedex = pokemonNames;
            [self.tableView reloadData];
        });
    }];
}

// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokedex.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.pokedex[indexPath.row].name capitalizedString];
    
    return cell;
}

// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    BRMPokemon *pokemon = self.pokedex[indexPath.row];
    
    [PokemonAPI.sharedController fillInDetailsFor:pokemon];
}

@end
