//
//  KRCPokemonTableViewController.m
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCPokemonTableViewController.h"
#import "Pokemon-Swift.h"
#import "KRCPokemon.h"

@interface KRCPokemonTableViewController ()

@property (nonatomic, nullable) NSArray<KRCPokemon *> *allPokemon;

@end

@implementation KRCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[KRCPokemonAPI sharded] fetchAllPokemonWithCompletion:^(NSArray<KRCPokemon *> * _Nullable pokemonList, NSError * _Nullable error) {
        
        NSLog(@"Finished Fetching all pokemon...");
        
        if (error) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setAllPokemon:pokemonList];
            [[self tableView] reloadData];
        });
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self allPokemon] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    KRCPokemon *pokemon = [[self allPokemon] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[pokemon name]];
    
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
