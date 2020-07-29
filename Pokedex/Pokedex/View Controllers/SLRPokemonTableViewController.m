//
//  SLRPokemonTableViewController.m
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

#import "SLRPokemonTableViewController.h"
#import "SLRPokemon.h"
#import "Pokedex-Swift.h"
#import "SLRDetailViewController.h"



@interface SLRPokemonTableViewController ()

@property PokemonAPI *apiData;
@property NSMutableArray <SLRPokemon *> *pokemon;

@end

@implementation SLRPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiData = [[PokemonAPI alloc] init];
    [self.apiData fetchAllPokemonWithCompletion:^(NSArray<SLRPokemon *> *listOfPokemon, NSError *error) {
        if (error) {
            NSLog(@"Error fetching Pokemon list: %@", error);
        }

        self.pokemon = [listOfPokemon mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pokemon count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemanCells" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.pokemon[indexPath.row] pokemonName];
    
    return cell;
}


#pragma mark - Navigation
//SegueToDetail
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    SLRDetailViewController *detailVC = segue.destinationViewController;
    detailVC.pokemon = [self.pokemon objectAtIndex:index.row];
}


@end
