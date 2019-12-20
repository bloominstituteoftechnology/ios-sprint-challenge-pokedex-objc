//
//  IJLPokedexTableViewController.m
//  Pokdex-Hybrid
//
//  Created by Isaac Lyons on 12/20/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "IJLPokedexTableViewController.h"
#import "IJLPokemon.h"
#import "Pokdex_Hybrid-Swift.h"

@interface IJLPokedexTableViewController ()

@property PokemonAPI *pokemonAPI;
@property NSArray<IJLPokemon *> *pokemon;

@end

@implementation IJLPokedexTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonAPI = [[PokemonAPI alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemonAPI fetchAllPokemonWithCompletion:^(NSArray<IJLPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            return NSLog(@"%@", error);
        }
        
        self.pokemon = pokemon;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pokemon count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    IJLPokemon *pokemon = self.pokemon[indexPath.row];
    [[cell textLabel] setText:[[pokemon name] capitalizedString]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PokemonDetailViewController *pokemonDetailVC = segue.destinationViewController;
    if (pokemonDetailVC && [pokemonDetailVC isKindOfClass:[PokemonDetailViewController class]]) {
        [pokemonDetailVC setPokemonAPI:self.pokemonAPI];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [pokemonDetailVC setPokemon:self.pokemon[indexPath.row]];
    }
}

@end
