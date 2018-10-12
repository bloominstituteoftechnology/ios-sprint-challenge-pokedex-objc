//
//  PokemonTableViewController.m
//  PokedexObjC
//
//  Created by Carolyn Lea on 10/12/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "PokemonDetailViewController.h"
#import "Pokemon.h"

@interface PokemonTableViewController ()

@end

@implementation PokemonTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Pokedex";
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<Pokemon *> *pokemons, NSError *error)
    {
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return PokemonController.sharedController.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    Pokemon *pokemon = [PokemonController.sharedController.pokemons objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetailView"])
    {
        
    }
 
}


@end
