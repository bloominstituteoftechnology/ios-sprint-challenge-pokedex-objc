//
//  STDPokemonTableViewController.m
//  ios-sprint12-challenge
//
//  Created by De MicheliStefano on 12.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

#import "STDPokemonTableViewController.h"
#import "STDPokemon.h"
#import "STDPokemonDetailViewController.h"
#import "ios_sprint12_challenge-Swift.h"

@interface STDPokemonTableViewController ()

@property NSMutableArray *pokemons;

@end

@implementation STDPokemonTableViewController

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
        
        for (STDPokemon *pokemon in pokemonList) {
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
    
    STDPokemon *pokemon = self.pokemons[indexPath.row];

    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetail"]) {
        STDPokemonDetailViewController *detailVC = segue.destinationViewController;
        PokemonAPI *pokemonApi = [PokemonAPI shared];
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        STDPokemon *pokemon = self.pokemons[indexPath.row];
        [pokemonApi fillInDetailsFor:pokemon];
        
        [detailVC setPokemon:pokemon];
    }
    
}

@end
