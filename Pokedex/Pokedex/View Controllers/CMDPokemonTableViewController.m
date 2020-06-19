//
//  CMDPokemonTableViewController.m
//  Pokedex
//
//  Created by Chris Dobek on 6/19/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import "CMDPokemonTableViewController.h"
#import "CMDPokemonDetailViewController.h"
#import "Pokedex-Swift.h"
#import "CMDPokemon.h"


@interface CMDPokemonTableViewController ()

@property NSArray<CMDPokemon *> *pokemon;

@end

@implementation CMDPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pokemon = [NSMutableArray new];
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<CMDPokemon *> * data, NSError * error) {
        self.pokemon = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowPokemonDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CMDPokemonDetailViewController *controller = (CMDPokemonDetailViewController *)[segue destinationViewController];
        controller.pokemon = _pokemon[indexPath.row];
        self.detailViewController = controller;
    }
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.pokemon[indexPath.row].name capitalizedString];
    return cell;
}

@end
