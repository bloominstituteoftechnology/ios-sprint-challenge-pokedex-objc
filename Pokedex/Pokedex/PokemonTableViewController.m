//
//  PokemonTableViewController.m
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.pokemon[indexPath.row].name;
    
    return cell;
}


// MARK: - Functions
- (void)updateViews
{
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<Pokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to fetch pokemon with error: %@", error);
            return;
        }

        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Pokemon array was nil");
            return;
        }
    }];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"PokemonDetailSegue"])
    {
        PokemonDetailViewController *pokemonDetailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        pokemonDetailVC.pokemon = [self.pokemon objectAtIndex:indexPath.row];
    }
}


@end
