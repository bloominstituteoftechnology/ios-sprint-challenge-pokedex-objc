//
//  CNSPokemonTableViewController.m
//  Dex
//
//  Created by Ezra Black on 6/19/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

#import "CNSPokemonTableViewController.h"
#import "DetailsViewController.h"
#import "CNSPokemon.h"
#import "Dex-Swift.h"

@interface CNSPokemonTableViewController ()
@property (nonatomic) NSArray<CNSPokemon *> *pokemon;
@end

@implementation CNSPokemonTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [CNSPokemonController.sharedController GETWithCompletion:^(NSArray<CNSPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        self.pokemon = pokemon;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    CNSPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        DetailsViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = [self.pokemon objectAtIndex:indexPath.row];
    }
}

@end
