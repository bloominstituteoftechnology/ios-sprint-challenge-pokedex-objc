//
//  DYPPokedexTableViewController.m
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPPokedexTableViewController.h"
#import "DYPPokemon.h"
#import "PokedexObjC-Swift.h"
#import "DYPPokemonDetailViewController.h"

@interface DYPPokedexTableViewController ()

@property (nonatomic) NSArray<DYPPokemon *> *pokemon;

@end

@implementation DYPPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<DYPPokemon *> *allPokemon, NSError *error) {
       
        if (error) {
            NSLog(@"Error search for all pokemon");
        }
        
        self.pokemon = allPokemon;
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    DYPPokemon *pokemon = self.pokemon[indexPath.row];
    [cell.textLabel setText:pokemon.name];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"ViewPokemon"]) {
        DYPPokemonDetailViewController *destinationVC = (DYPPokemonDetailViewController *)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DYPPokemon *pokemon = [self.pokemon objectAtIndex:[indexPath row]];
        [[PokemonAPI sharedController] fillInDetailsFor:pokemon];
    }
}

// MARK: - Properties

- (void)setPokemon:(NSArray<DYPPokemon *> *)pokemon
{
    _pokemon = [pokemon copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
