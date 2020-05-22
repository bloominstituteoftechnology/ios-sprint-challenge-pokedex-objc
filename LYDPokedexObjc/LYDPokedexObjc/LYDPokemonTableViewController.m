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
@property (nonatomic) LYDNetworking *networking;
@property (nonatomic) NSMutableArray *pokeMutArray;

@end

@implementation LYDPokemonTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pokeController = [[LYDPokemonController alloc]init];
    self.networking = [[LYDNetworking alloc]init];
    self.pokeMutArray = [[NSMutableArray alloc] init];
    [self.networking fetchPokeWithCompletion:^(NSArray<LYDPokemon *> *_Nullable pokemon, NSError *_Nullable error){
        if (error) {return;}
        [self.pokeController addPoke:pokemon];
        self.pokeMutArray = [NSMutableArray arrayWithArray:pokemon];
        NSLog(@"%lu", (unsigned long)self.pokeMutArray.count);
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokeMutArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    LYDPokemon *pokemon = self.pokeMutArray[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LYDPokeDetailViewController *detailVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LYDPokemon *pokemon = self.pokeMutArray[indexPath.row];
    detailVC.pokemon = pokemon;
    detailVC.netWorking = self.networking;
}


@end
