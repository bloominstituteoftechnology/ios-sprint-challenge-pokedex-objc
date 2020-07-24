//
//  EJSPokedexTableViewController.m
//  PokemonObj-CSprint
//
//  Created by Enzo Jimenez-Soto on 7/24/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSPokedexTableViewController.h"
#import "EJSPokemon.h"
#import "EJSDetailViewController.h"
#import "PokemonObj-Swift.h"





@interface EJSPokedexTableViewController ()

// MARK: - Properties

@property (nonatomic) NSArray<EJSPokemon *> *pokedex;

@end

@implementation EJSPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
       [[PokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<EJSPokemon *> *results, NSError *error) {
           
           self.pokedex = results;
           dispatch_async(dispatch_get_main_queue(), ^{
               [self.tableView reloadData];
           });
       }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokedex.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    EJSPokemon *pokemon = self.pokedex[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}



// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        
        EJSDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        EJSPokemon *pokemon = self.pokedex[indexPath.row];
        detailVC.pokemon = pokemon;
        [[PokemonAPI sharedController] fillInDetailsFor:pokemon];
    }

}

@end
