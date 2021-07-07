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

void *KVOContext2 = &KVOContext2;

@interface DYPPokedexTableViewController ()

@property (nonatomic) NSArray<DYPPokemon *> *pokemon;
@property (nonatomic) DYPPokemon *pokemonSelected;

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
    [cell.textLabel setText:[pokemon.name capitalizedString]];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DYPPokemon *pokemon = [self.pokemon objectAtIndex:[indexPath row]];
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
////        [[PokemonAPI sharedController] fillInDetailsFor:pokemon];
////    });
//    self.pokemonSelected = pokemon;
//}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if (context == KVOContext2) {
//        DYPPokemon *pokemon = (DYPPokemon *)object;
//        //if (pokemon.sprite) {
//            [self performSegueWithIdentifier:@"ShowPokemon" sender:self];
//        //}
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"ShowPokemon"]) {
        DYPPokemonDetailViewController *destinationVC = (DYPPokemonDetailViewController *)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DYPPokemon *pokemon = [self.pokemon objectAtIndex:[indexPath row]];
        [destinationVC setPokemon:pokemon];
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

//- (void)setPokemonSelected:(DYPPokemon *)pokemonSelected
//{
//    if (pokemonSelected != _pokemonSelected) {
//        
//        [_pokemonSelected removeObserver:self forKeyPath:@"sprite" context:KVOContext2];
//        
//        _pokemonSelected = pokemonSelected;
//        
//        [_pokemonSelected addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionInitial context:KVOContext2];
//    }
//}

@end
