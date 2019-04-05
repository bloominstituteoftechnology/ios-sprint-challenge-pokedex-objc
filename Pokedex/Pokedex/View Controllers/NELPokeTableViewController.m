//
//  NELPokeTableViewController.m
//  Pokedex
//
//  Created by Nelson Gonzalez on 4/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

#import "NELPokeTableViewController.h"

@interface NELPokeTableViewController ()

@end

@implementation NELPokeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokeCell" forIndexPath:indexPath];
    
    
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}


@end
