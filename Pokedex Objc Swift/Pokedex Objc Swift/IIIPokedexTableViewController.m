//
//  IIIPokedexTableViewController.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokedexTableViewController.h"
#import "IIIPokemonDetailViewController.h"

@interface IIIPokedexTableViewController ()

@end

@implementation IIIPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CellSegue"]) {
//        IIIPokemonDetailViewController *destVC = segue.destinationViewController;
//        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
//        destVC.pokemon =
    }
}

@end
