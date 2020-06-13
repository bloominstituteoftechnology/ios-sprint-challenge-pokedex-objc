//
//  JAGPokedexTableViewController.m
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "JAGPokedexTableViewController.h"
#import "JAGPokemon.h"
#import "PokedexViewer-Swift.h"

@interface JAGPokedexTableViewController ()

@property (nonatomic) NSArray<JAGPokemon *> *pokemons;

@end

@implementation JAGPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [JAGPokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<JAGPokemon *> *pokemons, NSError *error) {
        if (error) {
            NSLog(@"Error fetching list of pokemon: %@", error);
        }
        self.pokemons = pokemons;
        [self.tableView reloadData];
    }];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    JAGPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
