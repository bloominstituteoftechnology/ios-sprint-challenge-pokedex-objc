//
//  XMPPokedexTableViewController.m
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

#import "XMPPokedexTableViewController.h"
#import "XMPPokedexDetailViewController.h"
#import "XMPPokemon.h"
#import "pokedex_objc-Swift.h"

@interface XMPPokedexTableViewController ()

@property (nonatomic) PokemonAPI *fetcher;
@property (nonatomic) NSArray<XMPPokemon*> *pokemon;

@end

@implementation XMPPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fetcher = [PokemonAPI new];
    [_fetcher fetchAllPokemonWithCompletion:^(NSArray<XMPPokemon *> *_Nullable pokemon, NSError *_Nullable error) {
        self.pokemon = pokemon;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    cell.textLabel.text = _pokemon[indexPath.row].name.capitalizedString;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if([segue.identifier isEqualToString:@"detailViewSegue"]) {
        XMPPokedexDetailViewController *detailVC = [segue destinationViewController];
        detailVC.pokemon = _pokemon[self.tableView.indexPathForSelectedRow.row];
    }
}

@end
