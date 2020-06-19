//
//  SDJPokedexTVC.m
//  ObjCPokedex
//
//  Created by Shawn James on 6/19/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

#import "SDJPokedexTVC.h"
#import "ObjCPokedex-Swift.h"
#import "SDJPokemon.h"

@interface SDJPokedexTVC ()

@property (nonatomic) SDJNetworkController *networkController;
@property (nonatomic, copy) NSArray<SDJPokemon *> *pokemon;

@end

@implementation SDJPokedexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.networkController fetchAllPokemonWithCompletion:^(NSArray<SDJPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        self.pokemon = pokemon;
        dispatch_sync(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    SDJPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}

- (SDJNetworkController *)networkController {
    if (!_networkController) {
        _networkController = [SDJNetworkController new];
    }
    return _networkController;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailVC *detailVC = (DetailVC *)segue.destinationViewController;
    detailVC.networkController = self.networkController;
    detailVC.pokemon = self.pokemon[indexPath.row];
}

@end
