//
//  BHPokemonTableViewController.m
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import "BHPokemonTableViewController.h"
#import "BHPokemonTableViewCell.h"
#import "PokedexObjC-Swift.h"

@interface BHPokemonTableViewController ()

@property PokemonController *pokemonController;

@end

@implementation BHPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonController = [PokemonController shared];
    [_pokemonController getAvailablePokemonWithCompletionBlock:^(NSArray<BHPokemonTemporaryResults*> *tempResults, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pokemonController.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BHPokemonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_pokemonController.results[indexPath.row] name];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BHPokemonTableViewCell *cell = sender;
    PokemonDetailViewController *destVC = [segue destinationViewController];
    
    destVC.pokemonName = [[cell textLabel] text];
    destVC.pokemonController = [self pokemonController];
    
}

@end
