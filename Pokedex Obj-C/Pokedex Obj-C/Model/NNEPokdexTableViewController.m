//
//  NNEPokdexTableViewController.m
//  Pokedex Obj-C
//
//  Created by Nonye on 7/24/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import "NNEPokdexTableViewController.h"
#import "Pokedex_Obj_C-Swift.h"
#import "NNEPokdex.h"
#import "NNEPokedexDetailsViewController.h"


@interface NNEPokdexTableViewController ()

@property (nonatomic) PokedexController *pokedexController;
@property (nonatomic, copy) NSArray<NNEPokdex *> *pokemon;

@end


@implementation NNEPokdexTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokedexController = [[PokedexController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.pokedexController fetchPokemonWithCompletion:^(NSArray<NNEPokdex *> * _Nullable pokemon, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    NNEPokdex *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

- (PokedexController *)pokemonController {
    if (!_pokedexController) {
        _pokedexController = [[PokedexController alloc] init];
    }
    return _pokedexController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"PokemonDetailSegue"]){
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        NNEPokedexDetailsViewController *controller = (NNEPokedexDetailsViewController *)segue.destinationViewController;
        controller.pokedexController = self.pokedexController;
        controller.pokemon = self.pokemon[selectedIndexPath.row];}
}




@end
