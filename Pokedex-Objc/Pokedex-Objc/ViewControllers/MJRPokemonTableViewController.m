//
//  MJRPokemonTableViewController.m
//  Pokedex-Objc
//
//  Created by Marlon Raskin on 10/18/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRPokemonTableViewController.h"
#import "MJRDetailViewController.h"
#import "MJRPokemon.h"
#import <Pokedex_Objc-Swift.h>
//#import "Pokedex_Objc-Swift.h"



@interface MJRPokemonTableViewController ()

@property (nonatomic) NSMutableArray *pokeArray;

@property PokemonAPI *pokeController;

@end

@implementation MJRPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokeController = [[PokemonAPI alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
//    NSMutableArray *array = [@[@"Pikachu", @"Bulbasaur", @"Eevee"] mutableCopy];
//    _pokeArray = array;

    [self.pokeController fetchAllPokemonWithCompletion:^(NSArray<MJRPokemon *> * _Nullable array, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%lu", array.count);
            [self.tableView  reloadData];
        });
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pokeController.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

    MJRPokemon *pokemon = self.pokeController.allPokemon[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    
    return cell;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetailSegue"]) {
        MJRDetailViewController *detailVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MJRPokemon *pokemon = self.pokeController.allPokemon[indexPath.row];
        detailVC.pokemon = pokemon;
        [self.pokeController fillInDetailsFor:pokemon];
    }
}

@end
