//
//  JLRPokedexTableViewController.m
//  Jesse's Pokedex
//
//  Created by Jesse Ruiz on 12/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JLRPokedexTableViewController.h"

@interface JLRPokedexTableViewController ()

@end

@implementation JLRPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
