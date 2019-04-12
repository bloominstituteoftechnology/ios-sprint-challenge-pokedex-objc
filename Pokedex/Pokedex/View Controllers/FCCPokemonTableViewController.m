//
//  FCCPokemonTableViewController.m
//  Pokedex
//
//  Created by Lambda_School_Loaner_34 on 4/12/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

#import "FCCPokemonTableViewController.h"
#import "FCCDetailPokemonViewController.h"
#import "Pokedex-Swift.h"
#import "FCCPokemon.h"

@interface FCCPokemonTableViewController ()
@property (nonatomic) NSArray<FCCPokemon *> *pokedex;
@end

@implementation FCCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokemonController sharedController] fetchAllPokemonWithCompletion:^(NSArray<FCCPokemon *> * pokedex, NSError * error) {
        
        self.pokedex = pokedex;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self pokedex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    FCCPokemon *pokemon = self.pokedex[indexPath.row];
    
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PokemonSegue"]) {
        
        FCCPokemonDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        FCCPokemon *pokemon = self.pokedex[indexPath.row];
        destination.pokemon = pokemon;
        
        [[PokemonController sharedController] fillInDetailsFor:pokemon];
    }
}

@end
