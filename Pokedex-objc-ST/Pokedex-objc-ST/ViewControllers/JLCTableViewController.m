//
//  JLCTableViewController.m
//  Pokedex-objc-ST
//
//  Created by Jake Connerly on 11/15/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCTableViewController.h"
#import "Pokedex_objc_ST-Swift.h"
#import "JLCPokemon.h"

@interface JLCTableViewController ()

@property PokeController *pokeController;


@end

@implementation JLCTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokeController = [[PokeController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokeController fetchAllPokemonWithCompletion:^(NSArray<JLCPokemon *> * pokemon, NSError * error) {
        if (error) {
            NSLog(@"Error when fetching pokemon in viewController: %@", error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokeController.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    JLCPokemon *pokemon = self.pokeController.allPokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowPokeSegue"]) {
        JLCPokemonDetailViewController *pokeDetailVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        JLCPokemon *selectedPokemon = self.pokeController.allPokemon[indexPath.row];
        pokeDetailVC.pokeName = selectedPokemon.name;
        pokeDetailVC.pokeController = self.pokeController;
    }
}


@end
