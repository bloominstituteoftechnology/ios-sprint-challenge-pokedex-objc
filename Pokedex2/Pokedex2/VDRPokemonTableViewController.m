//
//  VDRPokemonTableViewController.m
//  Pokedex2
//
//  Created by Victor  on 7/26/19.
//  Copyright © 2019 Victor . All rights reserved.
//

#import "VDRPokemonTableViewController.h"
#import "VDRPokemon.h"
#import "VDRPokemonDetailViewController.h"
#import "Pokedex2-Swift.h"

@interface VDRPokemonTableViewController ()

@property NSMutableArray *pokemons;

@end

@implementation VDRPokemonTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pokemons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    PokemonAPI *pokemonApi = [PokemonAPI shared];
    
    [pokemonApi fetchAllPokemonWithCompletion:^(NSArray * pokemonList, NSError * error) {
        if (error) {
            NSLog(@"Error fetching pokemons %@", error);
            return;
        }
        
        for (VDRPokemon *pokemon in pokemonList) {
            [self.pokemons addObject:pokemon];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.tableView reloadData];
        });
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    VDRPokemon *pokemon = self.pokemons[indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetail"]) {
        VDRPokemonDetailViewController *detailVC = segue.destinationViewController;
        PokemonAPI *pokemonApi = [PokemonAPI shared];
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        VDRPokemon *pokemon = self.pokemons[indexPath.row];
        [pokemonApi fillInDetailsFor:pokemon];
        
        [detailVC setPokemon:pokemon];
    }
    
}

@end
