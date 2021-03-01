//
//  TableViewController.m
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/24/21.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "Pokemon.h"
#import "ObjCPokedex-Bridging-Header.h"
#import "ObjCPokedex-Swift.h"

@interface TableViewController ()

@property (nonatomic) NSArray<Pokemon *> *pokemonList;

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.sharedController fetchPokemonWithCompletion:^(NSArray<Pokemon *> *pokemonArray, NSError *error) {
        if (error) {
            NSLog(@"Error fetching pokemon list: %@", error);
        }
        self.pokemonList = pokemonArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _pokemonList[indexPath.row].name.capitalizedString;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPokemon"]) {
        ViewController *detailVC = (ViewController *)segue.destinationViewController;
        Pokemon *pokemon = [_pokemonList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [PokemonController.sharedController pokemonResultWith:pokemon];
            detailVC.pokemon = pokemon;
        });
        NSLog(@"Your name is %@", pokemon.identifier);
        
        if (pokemon.identifier == nil) {
            [self willChangeValueForKey:@"sprites"];
            [PokemonController.sharedController pokemonResultWith:pokemon];
            [self didChangeValueForKey:@"sprites"];
        }
    }
}


@end
