//
//  SKSPokedexTableViewController.m
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSPokedexTableViewController.h"
#import "SKSPokemonDetailViewController.h"
#import "SKSPokemonController.h"
#import "SKSPokemon.h"

@interface SKSPokedexTableViewController ()

@property (nonatomic) SKSPokemonController *pokemonController;

@end

@implementation SKSPokedexTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[SKSPokemonController alloc] init];
    }
    return self;
}

static NSString * const reuseIdentifier = @"PokemonCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.pokemonController fetchPokemonWithPokemonAPI:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"# pokemon fetched: %lu", [self.pokemonController getPokemons].count);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }

    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pokemonController getPokemons].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [self.pokemonController getPokemons][indexPath.row].name;

    return cell;
}


 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     SKSPokemonDetailViewController *detailVC = [segue destinationViewController];
     if ([segue.identifier isEqualToString:@"ShowPokemonDetailSegue"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         detailVC.pokemonController = self.pokemonController;
         detailVC.pokemon = [self.pokemonController getPokemons][indexPath.row];
     }
 }


@end
