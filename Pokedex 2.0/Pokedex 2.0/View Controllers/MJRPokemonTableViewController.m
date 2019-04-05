//
//  MJRPokemonTableViewController.m
//  Pokedex 2.0
//
//  Created by Moses Robinson on 4/5/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

#import "MJRPokemonTableViewController.h"

@interface MJRPokemonTableViewController ()



@end

@implementation MJRPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    
}


@end
