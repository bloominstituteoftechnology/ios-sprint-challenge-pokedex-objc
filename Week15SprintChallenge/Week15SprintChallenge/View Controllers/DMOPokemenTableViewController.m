//
//  DMOPokemenTableViewController.m
//  Week15SprintChallenge
//
//  Created by morse on 1/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOPokemenTableViewController.h"
#import "Week15SprintChallenge-Swift.h"
#import "DMOPokemon.h"

@interface DMOPokemenTableViewController ()

@property NSArray<DMOPokemon *> *pokemen;

@end

@implementation DMOPokemenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNames];
}

- (void)loadNames {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<DMOPokemon *> *pokemonNames, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemen = pokemonNames;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemen.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.pokemen[indexPath.row].name;
    
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
