//
//  OTKPokedexTableViewController.m
//  Pokedex
//
//  Created by Tobi Kuyoro on 22/05/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

#import "OTKPokedexTableViewController.h"
#import "OTKPokemon.h"
#import "Pokedex-Swift.h"

@interface OTKPokedexTableViewController ()

@end

@implementation OTKPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.apiController fetchAllPokemonWithCompletion:^(NSArray<OTKPokemon *> *pokemon, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
    }];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _apiController = [APIController sharedController];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apiController.pokedex.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    OTKPokemon *pokemon = self.apiController.pokedex[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
