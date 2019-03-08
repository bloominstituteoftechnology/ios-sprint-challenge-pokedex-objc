//
//  PokedexTableViewController.m
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "DRMPokemon.h"
#import "PokedexObjc-Swift.h"

@interface PokedexTableViewController ()

@property NSArray<DRMPokemon *> *pokemons;

@end

@implementation PokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pokemons = [NSArray array];
    
    [PokemonAPI.shared fetchAllPokemonWithCompletion:^(NSArray<DRMPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        self.pokemons = pokemons;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    DRMPokemon *pokemon = self.pokemons[indexPath.row];
    
    [cell.textLabel setText:[pokemon.name capitalizedString]];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
