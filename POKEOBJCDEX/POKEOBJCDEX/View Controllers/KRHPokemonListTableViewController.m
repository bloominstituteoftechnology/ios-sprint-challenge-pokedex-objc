//
//  KRHPokemonListTableViewController.m
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "KRHPokemonListTableViewController.h"
#import "KRHPokemon.h"
#import "KRHPokemonDetailViewController.h"
#import "POKEOBJCDEX-Swift.h"

@interface KRHPokemonListTableViewController ()


@end

@implementation KRHPokemonListTableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self updateViews];
}

#pragma mark - Functions
-(void)updateViews {
    
    [PokemonAPI.sharedController fetchAllPokemonsWithCompletion:^(NSArray<KRHPokemon *> * pokemon, NSError * error) {
        
        if (pokemon) {
            self.arrayOfPokemonNames = pokemon;
            NSLog(@"%@",pokemon);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Unable to load pokemon.");
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayOfPokemonNames.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    KRHPokemon *pokemon = self.arrayOfPokemonNames[indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetail"]) {
        KRHPokemonDetailViewController *destinationVC = (KRHPokemonDetailViewController *)segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        KRHPokemon *selectedPokemon = self.arrayOfPokemonNames[selectedIndexPath.row];

        [PokemonAPI.sharedController fillInDetailsFor:selectedPokemon];

        destinationVC.pokemon = selectedPokemon;
    }
}


@end
