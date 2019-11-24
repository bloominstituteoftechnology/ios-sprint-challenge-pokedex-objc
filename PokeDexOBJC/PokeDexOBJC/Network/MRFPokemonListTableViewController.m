//
//  MRFPokemonListTableViewController.m
//  PokeDexOBJC
//
//  Created by Michael Flowers on 11/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFPokemonListTableViewController.h"
//NEED ACCESS TO SWIFT FILES
#import "PokeDexOBJC-Swift.h"
#import "MRFPokemon.h"
#import "MRFDetailViewController.h"


@interface MRFPokemonListTableViewController ()

@property MRFNetwork *network;

@end

@implementation MRFPokemonListTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        _network = [MRFNetwork shared];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.network fetchAllPokemonWithCompletion:^(NSArray<MRFPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"error actually fetching");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.network.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];

    MRFPokemon *pokemon = self.network.pokemons[indexPath.row];
       // Configure the cell...
       cell.textLabel.text = pokemon.name;
    // Configure the cell...

    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"cellSegue"])
    {
        MRFDetailViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        MRFPokemon *pokemon = self.network.pokemons[indexPath.row];
        destinationVC.pokemon = pokemon;
        NSLog(@"this is the tapped pokemon name: %@", self.network.pokemons[indexPath.row]);
    }
}


@end
