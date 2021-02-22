//
//  PokemonTableViewController.m
//  PokedexObjc
//
//  Created by Kenneth Jones on 2/19/21.
//

#import "PokemonTableViewController.h"
#import "PokemonDetailViewController.h"
#import "PokedexObjc-Swift.h"

@interface PokemonTableViewController ()

@property (nonatomic) NSArray<NSString *> *pokemon;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.shared fetchAllWithCompletion:^(NSArray<NSString *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error fetching Pokemon data: %@", error);
            return;
        }
        
        self.pokemon = pokemon;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.pokemon objectAtIndex:indexPath.row].capitalizedString;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PokemonSegue"]) {
        PokemonDetailViewController *pokemonVC = [segue destinationViewController];
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        pokemonVC.pokemonName = self.pokemon[indexPath.row];
    }
}

@end
