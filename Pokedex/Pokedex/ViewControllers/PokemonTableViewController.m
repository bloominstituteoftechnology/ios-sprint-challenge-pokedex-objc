//
//  PokemonTableViewController.m
//  Pokedex
//
//  Created by Elizabeth Thomas on 10/13/20.
//

#import "PokemonTableViewController.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"
#import "PokemonDetailViewController.h"

@interface PokemonTableViewController ()

@property (nonatomic) NSArray<Pokemon *> *pokemon;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

    cell.textLabel.text = self.pokemon[indexPath.row].name;

    return cell;
}

// MARK: - Functions
- (void)updateViews;
{
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<Pokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to fetch pokemon: %@", error);
            return;
        }

        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Array was nil.");
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PokemonDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = self.pokemon[indexPath.row];
    }
}


@end
