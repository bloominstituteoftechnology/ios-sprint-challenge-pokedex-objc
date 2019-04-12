//
//  NYCPokemonTableViewController.m
//  Pokedex
//
//  Created by Nathanael Youngren on 4/12/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

#import "NYCPokemonTableViewController.h"
#import "NYCPokemon.h"
#import "NYCDetailViewController.h"
#import <Pokedex-Swift.h>

@interface NYCPokemonTableViewController ()

@property (nonatomic, strong) NSArray *pokemon;

@end

@implementation NYCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PokemonAPI *controller = [PokemonAPI sharedController];
    
    [controller fetchAllPokemonWithCompletion:^(NSArray<NYCPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"Error fetching Pokemon: %@", error);
            return;
        }
        self.pokemon = pokemon;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    NYCPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        NYCDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        detailVC.pokemon = self.pokemon[index.row];
    }
}

- (void)setPokemon:(NSArray *)pokemon {
    _pokemon = pokemon;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self tableView] reloadData];
    });
}

@end
