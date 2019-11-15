//
//  ARTableViewController.m
//  PokedexObjc
//
//  Created by Alex Rhodes on 11/14/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

#import "ARTableViewController.h"
#import "PokedexObjc-Swift.h"
#import "ARPokedexPokemon.h"

@interface ARTableViewController ()

@property PokemonController *pokemonController;

@end

@implementation ARTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<ARPokedexPokemon *> * _Nullable array, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Networkig Error");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [PokemonController shared];
    }
    return self;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonController.pokedex.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    ARPokedexPokemon *pokemon = self.pokemonController.pokedex[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PokemonDetailSegue"]) {
        PokemonDetailViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        destinationVC.pokemon = self.pokemonController.pokedex[indexPath.row];
    }
}

@end
