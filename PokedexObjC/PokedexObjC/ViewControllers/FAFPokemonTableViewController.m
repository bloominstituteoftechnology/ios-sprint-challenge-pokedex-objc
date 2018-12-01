//
//  FAFPokemonTableViewController.m
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import "FAFPokemonTableViewController.h"
#import "FAFDetailViewController.h"
#import "PokedexObjC-Swift.h"
#import "FAFPokemon.h"

@interface FAFPokemonTableViewController ()

@end

@implementation FAFPokemonTableViewController
    
    
- (instancetype)initWithCoder:(NSCoder *)aDecoder
    {
        self = [super initWithCoder:aDecoder];
        if (self) {
            [[FAFPokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<FAFPokemon *> * fetchedPokemons, NSError * error) {
                FAFPokemonAPI.sharedController.pokemons = fetchedPokemons;
            }];
        }
        return self;
    }
    
    
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            [[FAFPokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<FAFPokemon *> * fetchedPokemons, NSError * error) {
                FAFPokemonAPI.sharedController.pokemons = fetchedPokemons;
            }];
        }
        return self;
    }

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return FAFPokemonAPI.sharedController.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    FAFPokemon *pokemon = [[[FAFPokemonAPI sharedController] pokemons] objectAtIndex:indexPath.row];
    
    [[cell textLabel] setTextColor:[UIColor colorNamed:@"white"]];
    cell.textLabel.text = pokemon.name.capitalizedString;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"ViewPokemon"]){
        
        FAFDetailViewController *destVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        
        FAFPokemon *pokemon = [[[FAFPokemonAPI sharedController] pokemons] objectAtIndex:indexPath.row];
        
        destVC.pokemon = pokemon;
        
    }
    
}


@end
