//
//  LMSPokemonTableViewController.m
//  Pokemon ObjC
//
//  Created by Lisa Sampson on 3/8/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

#import "LMSPokemonTableViewController.h"
#import "Pokemon ObjC-Bridging-Header.h"

@interface LMSPokemonTableViewController ()

@end

@implementation LMSPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    
    LMSPokemon *pokemon = self.pokemon[indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
