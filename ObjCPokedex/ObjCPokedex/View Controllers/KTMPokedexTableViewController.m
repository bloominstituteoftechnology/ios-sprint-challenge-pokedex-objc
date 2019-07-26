//
//  KTMPokedexTableViewController.m
//  ObjCPokedex
//
//  Created by Kobe McKee on 7/26/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

#import "KTMPokedexTableViewController.h"
#import "KTMPokemonDetailViewController.h"
#import "ObjCPokedex-Swift.h"
#import "KTMPokemon.h"


@interface KTMPokedexTableViewController ()
@property (nonatomic)NSArray<KTMPokemon *> *pokedex;
@end

@implementation KTMPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<KTMPokemon *> * pokedex, NSError * error) {
        self.pokedex = pokedex;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokedex.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    KTMPokemon *pokemon = self.pokedex[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.seguePokemon = self.pokedex[indexPath.row];
    
    [self performSegueWithIdentifier:@"PokemonDetailSegue" sender:self];
}




#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:(@"PokemonDetailSegue")]) {
        KTMPokemonDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = self.seguePokemon;
        NSLog(@"%@", self.seguePokemon.name);
        [[PokemonAPI sharedController] fillInDetailsFor:self.seguePokemon];
        
    }
    
}


@end
