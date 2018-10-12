//
//  DODPokemonTableViewController.m
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODPokemonTableViewController.h"

@interface DODPokemonTableViewController ()

@end

@implementation DODPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

@end
