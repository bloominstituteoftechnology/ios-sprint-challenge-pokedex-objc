//
//  PokemonTableViewController.m
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "PokedexSprintChallengeObjC-Swift.h"
#import "Pokemon.h"

@interface PokemonTableViewController () <UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic) UISearchController *searchController;
@property (nonatomic) NSArray<Pokemon *> *filteredPokemon;
@property (nonatomic) NSInteger selectedScopeButtonIndex;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"Search Pokemon";
    self.searchController.searchBar.showsScopeBar = YES;
    self.searchController.searchBar.scopeButtonTitles = @[@"Pokemon Name", @"Pokemon Type"];
    self.navigationItem.searchController = self.searchController;
    self.definesPresentationContext = YES;
    
    self.controller = PokemonController.sharedController;
    [self.controller getAllPokemonByTypeWithCompletion:^(NSMutableArray * _Nullable allPokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }

        if (allPokemon) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            NSArray *sortedArray = [allPokemon sortedArrayUsingDescriptors:@[sortDescriptor]];
            self.allPokemon = sortedArray;
            self.filteredPokemon = sortedArray;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    Pokemon *pokemon = self.filteredPokemon[indexPath.row];
    
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetailSegue"]) {
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Pokemon *pokemon = self.filteredPokemon[indexPath.row];
        
        detailVC.pokemon = pokemon;
        detailVC.controller = self.controller;
    }
}

#pragma mark - Search results updating delegate methods

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    if (searchText) {
        if (searchText.length != 0) {
            [self filterPokemonForSearchText:searchText];
        }
        else {
            self.filteredPokemon = self.allPokemon;
        }
        [self.tableView reloadData];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    self.selectedScopeButtonIndex = selectedScope;
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - Search bar helper methods


- (void)filterPokemonForSearchText:(NSString *)searchText
{
    NSString *filter = @"%K CONTAINS[cd] %@";
    NSPredicate *predicate = [NSPredicate new];
    if (self.selectedScopeButtonIndex == 0) {
        predicate = [NSPredicate predicateWithFormat:filter, @"name", searchText];
    } else if (self.selectedScopeButtonIndex == 1) {
        predicate = [NSPredicate predicateWithFormat:filter, @"type", searchText];
    }
    
    self.filteredPokemon = [self.allPokemon filteredArrayUsingPredicate:predicate];
}

@end
