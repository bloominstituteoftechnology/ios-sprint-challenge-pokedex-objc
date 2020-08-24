//
//  SLBPokedexTableViewController.m
//  Pokedex ObjC
//
//  Created by Scott Bennett on 11/30/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

#import "SLBPokedexTableViewController.h"
#import "SLBPokemon.h"
#import "Pokedex_ObjC-Swift.h"

@interface SLBPokedexTableViewController ()


@property (nonatomic, strong) NSArray<SLBPokemon *> *pokemons;

@end

@implementation SLBPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

// MARK: - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonName" forIndexPath:indexPath];
    
    SLBPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}



// MARK: - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
