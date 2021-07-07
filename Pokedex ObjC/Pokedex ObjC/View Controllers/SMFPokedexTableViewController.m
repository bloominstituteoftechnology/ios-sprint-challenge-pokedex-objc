//
//  SMFPokedexTableViewController.m
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

#import "SMFPokedexTableViewController.h"
#import "SMFPokemonDetailViewController.h"
#import "SMFPokemon.h"
#import "Pokedex_ObjC-Swift.h"


@interface SMFPokedexTableViewController ()

@property SMFPokemonController *pokemonController;
@property NSArray<SMFPokemon *> *pokemons;

@end

@implementation SMFPokedexTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _pokemonController = [SMFPokemonController sharedController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pokemonController = [SMFPokemonController sharedController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<SMFPokemon *> *pokemons, NSError *error) {
        self.pokemons = pokemons;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pokemons.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    SMFPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"ShowPokemonDetail"]) {
        SMFPokemonDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SMFPokemon *pokemon = self.pokemons[indexPath.row];
        destination.pokemonController = [SMFPokemonController sharedController];
        // needs to be after pokemonController is set
        destination.pokemon = pokemon;
    }
}

@end
