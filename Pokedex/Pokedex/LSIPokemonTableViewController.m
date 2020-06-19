//
//  LSIPokemonTableViewController.m
//  Pokedex
//
//  Created by Bhawnish Kumar on 6/19/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

#import "LSIPokemonTableViewController.h"
#import "Pokedex-Swift.h"
#import "LSIPokemon.h"
#import "LSIDetailViewController.h"
@interface LSIPokemonTableViewController ()

@property (nonatomic) PokemonController *pokemonController;
@property (nonatomic, copy) NSArray<LSIPokemon *> *pokemon;

@end

@implementation LSIPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<LSIPokemon *> * _Nullable pokemon, NSError* _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
      return self.pokemon.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

     LSIPokemon *pokemon = self.pokemon[indexPath.row];
     cell.textLabel.text = pokemon.name;
     return cell;
 }

- (PokemonController *)pokemonController {
    if (!_pokemonController) {
        _pokemonController = [[PokemonController alloc] init];
    }
    return _pokemonController;
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
