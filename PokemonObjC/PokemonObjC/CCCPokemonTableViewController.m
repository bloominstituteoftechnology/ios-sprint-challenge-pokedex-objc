//
//  CCCPokemonTableViewController.m
//  PokemonObjC
//
//  Created by Ryan Murphy on 7/26/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

#import "CCCPokemonTableViewController.h"
#import "CCCDetialViewController.h"
#import "CCCPokemon.h"
#import "PokemonObjC-Swift.h"

@interface CCCPokemonTableViewController ()

@property (nonatomic, strong) NSArray<CCCPokemon *> *allPokemon;
@property (nonatomic, readonly) PokemonAPI *pokemonController;

@end

@implementation CCCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonController = [PokemonAPI sharedController];
    
    [_pokemonController fetchAllPokemonWithCompletion:^(NSArray<CCCPokemon *> *allPokemon, NSError *error) {
        if (error) {
            NSLog(@"Error TableVC ln: 30");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.allPokemon = allPokemon;
            [self.tableView reloadData];
        });
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    CCCPokemon *pokemon = self.allPokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CCCDetialViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = self.allPokemon[indexPath.row];
   
    }
}

@end
