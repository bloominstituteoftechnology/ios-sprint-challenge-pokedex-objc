//
//  CLBMasterViewControllerTableViewController.m
//  Pokedex - Obj-C
//
//  Created by Christian Lorenzo on 6/13/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import "CLBMasterViewControllerTableViewController.h"
#import "CLBDetailViewController.h"
#import "Pokedex___Obj_C-Swift.h"
#import "CLBPokemon.h"


@interface CLBMasterViewControllerTableViewController ()

@property NSArray<CLBPokemon *> *pokemon;

@end

@implementation CLBMasterViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (CLBDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    _pokemon = [NSMutableArray new];
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<CLBPokemon *> * data, NSError * error) {
        self.pokemon = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CLBDetailViewController *controller = (CLBDetailViewController *)[[segue destinationViewController] topViewController];
        controller.pokemon = _pokemon[indexPath.row];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
        self.detailViewController = controller;
    }
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.pokemon[indexPath.row].name capitalizedString];
    return cell;
}

@end
