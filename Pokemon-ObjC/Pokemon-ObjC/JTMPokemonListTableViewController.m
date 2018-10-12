//
//  JTMPokemonListTableViewController.m
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/12/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import "JTMPokemonListTableViewController.h"

@interface JTMPokemonListTableViewController ()

@end

@implementation JTMPokemonListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
