//
//  LYDPokemonTableViewController.m
//  LYDPokedexObjc
//
//  Created by Lydia Zhang on 5/22/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import "LYDPokemonTableViewController.h"

@interface LYDPokemonTableViewController ()

@property (nonatomic) LYDPokemonController *pokeController;
@property (nonnull) LYDNetworking *fetcher;

@end

@implementation LYDPokemonTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pokeController = [[LYDPokemonController alloc]init];
    [self.fetcher fetchPokeWithCompletion:^(NSArray<LYDPokemon *> *_Nullable pokemon, NSError *_Nullable error){
        
        if (error) {return;}
        [self.pokeController addPoke:pokemon];
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokeController.pokeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    LYDPokemon *pokemon = self.pokeController.pokeArray[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LYDPokeDetailViewController *detailVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LYDPokemon *pokemon = self.pokeController.pokeArray[indexPath.row];
    detailVC.netWorking = self.fetcher;
    detailVC.pokemon = pokemon;
}


@end
