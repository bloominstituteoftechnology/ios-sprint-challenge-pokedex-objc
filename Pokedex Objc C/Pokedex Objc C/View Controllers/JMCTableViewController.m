//
//  JMCTableViewController.m
//  Pokedex Objc C
//
//  Created by Jarren Campos on 8/14/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

#import "JMCTableViewController.h"
#import "JMCPokemon.h"
#import "JMCDetailViewController.h"
#import "Pokedex_Objc_C-Swift.h"


@interface JMCTableViewController ()

@property (nonatomic) NSArray<JMCPokemon *> *pokemon;

@end

@implementation JMCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [PokemonController.sharedController fetchPokemonWithCompletion:^(NSArray<JMCPokemon *> * pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error fetching pokemon: %@", error);
        }

        self.pokemon = pokemon;
        [self.tableView reloadData];

    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];

    JMCPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;

    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetailVC"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        JMCDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = [self.pokemon objectAtIndex:indexPath.row];
    }
}

@end
