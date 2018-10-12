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

@property (nonatomic, strong) Pokemon *pokemon;

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
    
    self.pokemon = [PokemonController.sharedController.pokemons objectAtIndex:indexPath.row];
    
    cell.textLabel.text = self.pokemon.name;
    
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetailView"])
    {
        PokemonDetailViewController *detailView = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.pokemon = PokemonController.sharedController.pokemons[indexPath.row];
        detailView.pokemon = self.pokemon;
    }
 
}


@end
