//
//  PokedexTableView.m
//  PokedexSprint
//
//  Created by Norlan Tibanear on 1/31/21.
//

#import "PokedexTableView.h"
//#import "PokedexSprint-Bridging-Header.h"
#import "Pokemon.h"
#import "PokedexSprint-Swift.h"

@class PokemonController;

@interface PokedexTableView ()

@property (nonatomic) NSArray<Pokemon *> *pokemons;
//@property (nonatomic) <PokemonController *> *pokemonController;

@end

@implementation PokedexTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.shareController fetchPokemonsWithCompletion:^(NSArray<Pokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching Pokemons: %@", error);
        }
        self.pokemons = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        });
        
    }];
    
}//

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Pokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}//

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goToDetailVCSegue"]) {
        PokemonDetailVC *detailVC = (PokemonDetailVC *)segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailVC.pokemon = self.pokemons[indexPath.row];
    }
    
}//



@end
