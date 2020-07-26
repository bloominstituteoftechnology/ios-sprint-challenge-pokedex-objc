//
//  HMRPokedexTableViewController.m
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

#import "HMRPokedexTableViewController.h"
#import "HMRDetailViewController.h"
#import "HMRPokemon.h"
#import "PokedexObjC-Swift.h"

@interface HMRPokedexTableViewController ()

@property (nonatomic) PokemonController *pokemonController;
@property (nonatomic, copy) NSArray<HMRPokemon *> *pokemon;

@end


@implementation HMRPokedexTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[PokemonController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.pokemonController fetchPokemonWithCompletion:^(NSArray<HMRPokemon *> * _Nullable pokemon, NSError * _Nullable error) {

        if (error) {
            NSLog(@"%@", error);
        }

        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

// Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

    HMRPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

- (PokemonController *)pokemonController {
    if (!_pokemonController) {
        _pokemonController = [[PokemonController alloc] init];
    }
    return _pokemonController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"PokemonDetailSegue"]){
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        HMRDetailViewController *controller = (HMRDetailViewController *)segue.destinationViewController;
        controller.pokemonController = self.pokemonController;
        controller.pokemon = self.pokemon[selectedIndexPath.row];}
}




@end
