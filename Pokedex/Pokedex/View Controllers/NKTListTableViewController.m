//
//  NKTListTableViewController.m
//  Pokedex
//
//  Created by Nikita Thomas on 2/1/19.
//  Copyright © 2019 Nikita Thomas. All rights reserved.
//

#import "NKTListTableViewController.h"
#import "NKTPokemon.h"
#import "Pokedex-Swift.h"
#import "DetailViewController.h"

@interface NKTListTableViewController ()

@end

@implementation NKTListTableViewController



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[PokemonAPI shared] fetchPokemonWithCompletion:^(NSArray<NKTPokemon *> * fetchedPokemon, NSError * error)
         {
             PokemonAPI.shared.pokemon = fetchedPokemon;
         }];
    }
    return self;
}


- (void)viewDidLoad
{
    [[PokemonAPI shared] fetchPokemonWithCompletion:^(NSArray<NKTPokemon *> * fetchedPokemon, NSError * error)
     {
         PokemonAPI.shared.pokemon = fetchedPokemon;
         dispatch_async(dispatch_get_main_queue(),^{
             [[self tableView] reloadData];
         });
     }];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return PokemonAPI.shared.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NKTPokemon *pokemon = [[[PokemonAPI shared] pokemon] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"toDetail"])
    {
        DetailViewController *dest = segue.destinationViewController;
        NSIndexPath *selectedIndex = [[self tableView] indexPathForSelectedRow];
        
        NKTPokemon *pokemon = [[[PokemonAPI shared] pokemon] objectAtIndex:selectedIndex.row];
        
        dest.pokemon = pokemon;
        
    }
}





@end
