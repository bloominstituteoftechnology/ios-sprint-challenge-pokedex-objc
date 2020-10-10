//
//  JSKPokemonTableViewController.m
//  Pokedex
//
//  Created by Josh Kocsis on 10/9/20.
//

#import "JSKPokemonTableViewController.h"
#import "Pokedex-Swift.h"
#import "JSKPokemon.h"
#import "JSKPokemonTableViewCell.h"

@class PokemonNetwork;

@interface JSKPokemonTableViewController ()

@property (nonatomic) NSMutableArray<JSKPokemon *> *pokemon;
@property (nonatomic) PokemonNetwork *pokemonController;

@end

@implementation JSKPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self pokemonController] fetchPokemonWithCompletion:^(NSArray<JSKPokemon *> *_Nullable pokemon, NSError *_Nullable error) {
        if (error) {
            return;
        }

        if (pokemon) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self pokemon] addObjectsFromArray:pokemon];
                [[self tableView] reloadData];
            });
        }

    }];

}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _pokemonController = [[PokemonNetwork alloc] init];
        _pokemon = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        _pokemonController = [[PokemonNetwork alloc] init];
        _pokemon = [[NSMutableArray alloc] init];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSKPokemonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

    JSKPokemon *pokemon = [[self pokemon] objectAtIndex:indexPath.row];
    cell.pokemonController = self.pokemonController;
    cell.pokemon = pokemon;

    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PokemonDetailSegue"]) {
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:sender];
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = [[self pokemon] objectAtIndex:indexPath.item];
        detailVC.pokemonController = [self pokemonController];
    }
}

@end
