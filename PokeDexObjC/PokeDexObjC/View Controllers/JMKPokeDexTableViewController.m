//
//  JMKPokeDexTableViewController.m
//  PokeDexObjC
//
//  Created by TuneUp Shop  on 3/15/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

#import "JMKPokeDexTableViewController.h"
#import "JMKPokemon.h"
#import "PokeDexObjC-Swift.h"
#import "JMKPokeDexDetailViewController.h"

@interface JMKPokeDexTableViewController ()

@property NSArray<JMKPokemon *> *allPokemon;

@end

@implementation JMKPokeDexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allPokemon = [NSArray array];
    [[PokemonAPI shared] fetchAllPokemonWithCompletion:^(NSArray<JMKPokemon *> * allPokemon, NSError * error) {
        self.allPokemon = allPokemon;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    JMKPokemon *pokemon = self.allPokemon[indexPath.row];
    [cell.textLabel setText:pokemon.name];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    JMKPokeDexDetailViewController *destinationVC = segue.destinationViewController;
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    JMKPokemon *pokemon = self.allPokemon[indexPath.row];
    [[PokemonAPI shared] fillInDetailsFor:pokemon];
    destinationVC.pokemon = pokemon;
}


@end
