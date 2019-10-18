//
//  JSPokeListVC.m
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import "JSPokeListVC.h"

@interface JSPokeListVC ()

@end

@implementation JSPokeListVC

// MARK: - IBOutlets


// MARK: - Properties


// MARK: - Life Cycle

- (void)viewDidLoad {
	[super viewDidLoad];
}

// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

// MARK: - IBActions


// MARK: - Helpers


// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
