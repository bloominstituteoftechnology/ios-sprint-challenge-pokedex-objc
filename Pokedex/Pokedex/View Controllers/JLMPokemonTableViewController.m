//
//  JLMPokemonTableViewController.m
//  Pokedex
//
//  Created by Jason Modisett on 2/1/19.
//  Copyright © 2019 Jason Modisett. All rights reserved.
//

#import "JLMPokemonTableViewController.h"
#import "JLMPokemonDetailViewController.h"
#import "JLMPokemon.h"
#import "Pokedex-Swift.h"

@interface JLMPokemonTableViewController ()

@property (nonatomic) NSArray<JLMPokemon *> *pokemon;

@end

@implementation JLMPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<JLMPokemon *> *pokemon, NSError *error) {
        self.pokemon = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    JLMPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    [cell.textLabel setText: [pokemon.name capitalizedString]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ViewPokemon"]) {
        JLMPokemonDetailViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        JLMPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
        
        [vc setPokemon:pokemon];
    }
}

@end
