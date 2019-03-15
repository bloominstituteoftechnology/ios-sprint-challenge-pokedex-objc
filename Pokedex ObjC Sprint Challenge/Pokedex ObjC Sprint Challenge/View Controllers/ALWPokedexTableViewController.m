//
//  ALWPokedexTableViewController.m
//  Pokedex ObjC Sprint Challenge
//
//  Created by Audrey Welch on 3/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

#import "ALWPokedexTableViewController.h"
#import "ALWPokemon.h"
#import "ALWDetailViewController.h"
#import "Pokedex_ObjC_Sprint_Challenge-Swift.h"

@interface ALWPokedexTableViewController ()

@property (nonatomic, strong) NSArray<ALWPokemon *> *allPokemon;

@end

@implementation ALWPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    ALWPokemon *pokemon = self.allPokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        
       // Get the new view controller using [segue destinationViewController].
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ALWDetailViewController *detailVC = segue.destinationViewController;
        
        // Pass the selected object to the new view controller.
        
    }
    
    
}


@end
