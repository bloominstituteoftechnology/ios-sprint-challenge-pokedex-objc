//
//  PokemonTableViewController.m
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "PokeController.h"
#import "Pokemon.h"
#import "PokemonDetailViewController.h"

void *KVOTableViewContext = &KVOTableViewContext;

@interface PokemonTableViewController ()

@property PokeController *pokeController;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pokeController = [[PokeController alloc] init];
    [self.pokeController addObserver:self forKeyPath:@"pokemonList" options:0 context:KVOTableViewContext];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokeController.pokemonList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    Pokemon *pokemon = self.pokeController.pokemonList[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOTableViewContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PokemonDetailViewController *detailVC = [segue destinationViewController];
    long index = self.tableView.indexPathForSelectedRow.row;
    detailVC.pokemon = self.pokeController.pokemonList[index];
}


@end
