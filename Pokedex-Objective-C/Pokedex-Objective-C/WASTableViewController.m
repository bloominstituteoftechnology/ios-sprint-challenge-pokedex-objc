//
//  WASTableViewController.m
//  Pokedex-Objective-C
//
//  Created by Alex Shillingford on 6/14/20.
//  Copyright © 2020 shillwil. All rights reserved.
//

#import "WASTableViewController.h"
#import "WASPokemon.h"
#import "Pokedex_Objective_C-Swift.h"
#import "WASDetailViewController.h"

@interface WASTableViewController ()

@property (nonatomic) NSArray<WASPokemon *> *allPokemon;

@end

@implementation WASTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadPokedex];
}

- (void)loadPokedex
{
    [[WASPokemonController sharedController] fetchAllPokemonWithCompletion:^(NSArray<WASPokemon *> *fetchedPokemon, NSError *error) {
        if (error) {
            NSLog(@"Error fetching names in TableViewController's `loadPokedex` method: %@", error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.allPokemon = fetchedPokemon;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
     cell.textLabel.text = self.allPokemon[indexPath.row].name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.identifier isEqualToString:@"PokeSegue"]) {
         WASDetailViewController *vc = segue.destinationViewController;
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         WASPokemon *pokemon = self.allPokemon[indexPath.row];
         vc.pokemon = pokemon;
     }
}


@end
