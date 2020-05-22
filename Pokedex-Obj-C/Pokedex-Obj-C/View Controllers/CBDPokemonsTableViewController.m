//
//  CBDPokemonsTableViewController.m
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "CBDPokemonsTableViewController.h"
#import "Pokedex_Obj_C-Swift.h"
#import "CBDPokemonShort.h"
#import "CBDDetailViewController.h"

@interface CBDPokemonsTableViewController ()

@property NetworkController *networkController;

@end

@implementation CBDPokemonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Pokedex";
    _networkController = NetworkController.sharedController;
    [self.networkController fetchAllPokemonWithCompletion:^(NSArray<CBDPokemonShort *> * _Nullable pokemons, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    }];
}

-(void)updateViews {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.networkController.pokemonList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    CBDPokemonShort *pokemonShort = self.networkController.pokemonList[indexPath.row];
    cell.textLabel.text = pokemonShort.name;
    
    return cell;
}

// MARK: - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        CBDDetailViewController *detailVC = [[CBDDetailViewController alloc] init];
        detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        detailVC.pokemonShort = self.networkController.pokemonList[indexPath.row];
        detailVC.networkController = self.networkController;
    }
}

@end
