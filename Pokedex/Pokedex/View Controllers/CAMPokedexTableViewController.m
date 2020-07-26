//
//  CAMPokedexTableViewController.m
//  Pokedex
//
//  Created by Cody Morley on 7/24/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMPokedexTableViewController.h"
#import "CAMPokemonDetailViewController.h"

@interface CAMPokedexTableViewController ()

@end

@implementation CAMPokedexTableViewController
//MARK: - Life Cycles -
- (void)viewDidLoad {
    [super viewDidLoad];
    _pokedex = PokedexAPIController.shared;
//    [self.pokedex addObserver:self
//                   forKeyPath:@"pokedex"
//                      options:0
//                      context:nil];
    
    [[self pokedex] fetchAllPokemonWithCompletion:^(NSError * _Nullable error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
    
}


//MARK: - Table view data source -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokedex.pokedex.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    NSString *pokemon = self.pokedex.pokedex[indexPath.row];
    cell.textLabel.text = pokemon;
    return cell;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
//                       context:(void *)context
//{
//    if ([keyPath isEqualToString:@"pokedex"]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    }
//}

//MARK: - Navigation -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        CAMPokemonDetailViewController *detailVC = [segue destinationViewController];
        detailVC.pokemonID = indexPath.row + 1;
        
    }
    // Pass the selected object to the new view controller.
}


@end
