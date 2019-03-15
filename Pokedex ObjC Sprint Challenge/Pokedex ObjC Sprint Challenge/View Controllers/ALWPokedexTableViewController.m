//
//  ALWPokedexTableViewController.m
//  Pokedex ObjC Sprint Challenge
//
//  Created by Audrey Welch on 3/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

#import "ALWPokedexTableViewController.h"

@interface ALWPokedexTableViewController ()

@end

@implementation ALWPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
