//
//  SAHPokemonTableViewController.m
//  Pokedex-Obj-C
//
//  Created by scott harris on 4/24/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHPokemonTableViewController.h"
#import "Pokedex_Obj_C-Swift.h"
#import "SAHPokemon.h"

@interface SAHPokemonTableViewController ()

@property (nonatomic, copy) NSArray<SAHPokemon *> *allPokemon;

@end

@implementation SAHPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:(^(NSArray<SAHPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"error getting pokemon");
            return;
        }
        
        if (pokemon) {
            self.allPokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    })];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    SAHPokemon *pokemon = self.allPokemon[indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetailSegue"]) {
        PokemonDetailViewController *detailVC = [segue destinationViewController];
        NSIndexPath *selectIndexPath = [self.tableView indexPathForSelectedRow];
        SAHPokemon * pokemon = self.allPokemon[selectIndexPath.row];
        detailVC.pokemon = pokemon;
        
    }
}

@end
