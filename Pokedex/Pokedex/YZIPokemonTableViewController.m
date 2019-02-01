//
//  YZIPokemonTableViewController.m
//  Pokedex
//
//  Created by Yvette Zhukovsky on 2/1/19.
//  Copyright © 2019 Yvette Zhukovsky. All rights reserved.
//
#import "YZIPokedex.h"
#import "YZIPokemonTableViewController.h"
#import "YZIPokemonViewController.h"
#import "Pokedex-Swift.h"

@interface YZIPokemonTableViewController ()
@property NSArray<YZIPokedex *> *pokemons;
@property YZIPokedexController *pokedexController ;
@end

@implementation YZIPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _pokedexController = [YZIPokedexController sharedController] ;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pokedexController = [YZIPokedexController sharedController] ;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokedexController fetchPokemonsWithCompletion: ^(NSArray<YZIPokedex *> *pokemons, NSError *error) {
        self.pokemons = pokemons;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pokemons.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    YZIPokedex *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"showPokemon"]) {
        YZIPokemonViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        YZIPokedex *pokemon = self.pokemons[indexPath.row];
        destination.pokedexController = [YZIPokedexController sharedController];
         destination.pokemon = pokemon;
}

}
@end
