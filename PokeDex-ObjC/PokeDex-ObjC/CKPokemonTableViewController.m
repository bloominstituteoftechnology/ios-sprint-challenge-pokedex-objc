//
//  CKPokemonTableViewController.m
//  PokeDex-ObjC
//
//  Created by Christy Hicks on 6/14/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

#import "CKPokemonTableViewController.h"
#import "PokeDex_ObjC-Swift.h"
#import "CKPokemon.h"
#import "CKPokemonDetailViewController.h"

@interface CKPokemonTableViewController ()

@property (nonatomic) CKPokemonController *pokemonController;
@property (nonatomic, copy) NSArray<CKPokemon *> *pokemon;

@end

@implementation CKPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<CKPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    CKPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

- (CKPokemonTableViewController *)pokemonController {
    if (!_pokemonController) {
        _pokemonController = [[CKPokemonController alloc] init];
    }
    return _pokemonController;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"DetailSegue"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        CKPokemonDetailViewController *controller = (CKPokemonDetailViewController *)segue.destinationViewController;
        controller.pokemonController = self.pokemonController;
        controller.pokemon = self.pokemon[selectedIndexPath.row];}
}

@end
