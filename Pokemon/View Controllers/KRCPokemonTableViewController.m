//
//  KRCPokemonTableViewController.m
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCPokemonTableViewController.h"
#import "KRCPokemonDetailViewController.h"
#import "Pokemon-Swift.h"
#import "KRCPokemon.h"

@interface KRCPokemonTableViewController ()

@property (nonatomic, nullable) NSArray<KRCPokemon *> *allPokemon;

@end

@implementation KRCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[KRCPokemonAPI sharded] fetchAllPokemonWithCompletion:^(NSArray<KRCPokemon *> * _Nullable pokemonList, NSError * _Nullable error) {
        
        NSLog(@"Finished Fetching all pokemon...");
        
        if (error) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setAllPokemon:pokemonList];
            [[self tableView] reloadData];
        });
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self allPokemon] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    KRCPokemon *pokemon = [[self allPokemon] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[pokemon name]];
    
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"ShowDetailView"]) {
        
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        KRCPokemon *selectedPokemon = [[self allPokemon] objectAtIndex:[indexPath row]];
        KRCPokemonDetailViewController *detailVC = [segue destinationViewController];
        
        [detailVC setPokemon:selectedPokemon];
    }
}


@end
