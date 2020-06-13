//
//  DSCPokemonTableViewController.m
//  PokedexOBJC
//
//  Created by denis cedeno on 6/12/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

#import "DSCPokemonTableViewController.h"
#import "DSCPokemon.h"


@interface DSCPokemonTableViewController ()

@property (nonatomic) NSMutableArray *pokemonArray;
@property PokemonAPI *pController;

@end


@implementation DSCPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]){
        _pController = [[PokemonAPI alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pController fetchAllPokemonWithCompletion:^(NSArray<DSCPokemon *> * _Nullable pokemonArray, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pController.pokemonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonNameCell" forIndexPath:indexPath];
    
    DSCPokemon *pokemon = self.pController.pokemonArray[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}


@end
