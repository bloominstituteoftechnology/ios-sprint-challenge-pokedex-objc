//
//  TableViewController.m
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/24/21.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "Pokemon.h"
#import "ObjCPokedex-Bridging-Header.h"
#import "ObjCPokedex-Swift.h"

@interface TableViewController ()

@property (nonatomic) NSArray<Pokemon *> *pokemonList;

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.sharedController fetchPokemonWithCompletion:^(NSArray<Pokemon *> *pokemonArray, NSError *error) {
            if (error) {
                NSLog(@"Error fetching pokemon list: %@", error);
            }
            self.pokemonList = pokemonArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _pokemonList[indexPath.row].name.capitalizedString;
    
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
    if ([segue.identifier isEqualToString:@"showPokemon"]) {
        ViewController *detailVC = (ViewController *)segue.destinationViewController;
        Pokemon *pokemon = [_pokemonList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailVC.pokemon = pokemon;
    }
}


@end
