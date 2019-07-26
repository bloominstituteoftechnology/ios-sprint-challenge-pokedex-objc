//
//  DLJPokemonTableViewController.m
//  ObjcPokemon
//
//  Created by Diante Lewis-Jolley on 7/26/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

#import "DLJPokemonTableViewController.h"
#import "DLJPokemon.h"
#import "DLJDetailViewController.h"
#import "ObjcPokemon-Swift.h"

@interface DLJPokemonTableViewController ()

@property PokemonController *pokemonController;
@property NSArray<DLJPokemon *> *pokedex;

@end

@implementation DLJPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _pokemonController = [PokemonController shared];

    [_pokemonController fetchPokemonWithCompletion:^(NSArray<DLJPokemon *> *pokedex, NSError * error) {
        if (error) {
            NSLog(@"Error fetching pokemon");
        }
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.pokedex = pokedex;
            [self.tableView reloadData];
        });

    }];

    

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.pokedex.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

    DLJPokemon *pokemon = self.pokedex[indexPath.row];
    cell.textLabel.text = pokemon.name;

    
    return cell;
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([segue.identifier isEqualToString:@"DetailSegue"]) {

        DLJDetailViewController *DetailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DLJPokemon *pokemon = self.pokedex[indexPath.row];
        DetailVC.pokemon = pokemon;

    }
}


@end
