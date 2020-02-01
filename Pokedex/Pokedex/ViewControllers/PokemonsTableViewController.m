//
//  PokemonsTableViewController.m
//  Pokedex
//
//  Created by brian vilchez on 1/31/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import "PokemonsTableViewController.h"
#import "Pokedex-Swift.h"
#import "BVPokemon.h"


@interface PokemonsTableViewController ()
@property PokemonController *pokemonController;
@property NSMutableArray<BVPokemon *> *pokemons;

@end

@implementation PokemonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self pokemonController] fetchAllPokemonWithCompletion:^(NSArray<BVPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if(pokemons) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self pokemons] addObjectsFromArray:pokemons];
                [[self tableView] reloadData];
            });
            
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pokemonController = [[PokemonController alloc] init];
        _pokemons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[PokemonController alloc] init];
        _pokemons = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return [[[self pokemonController]pokemons]count];
    return [[self pokemons]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
     BVPokemon *pokemon = [[self pokemons]objectAtIndex:indexPath.row];
//    BVPokemon *pokemon = [[[self pokemonController] pokemons]objectAtIndex:indexPath.row];
    [[cell textLabel] setText: pokemon.name];
    return cell;
}


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"PokemonDetailSegue"]) {
     NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
     PokemonViewController *pokemonDetailVC = segue.destinationViewController;
     pokemonDetailVC.pokemon = [[self pokemons] objectAtIndex:indexPath.row];
     pokemonDetailVC.pokemonController = [self pokemonController];
 }
}

@end
