//
//  BTPokemonListTableViewController.m
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import "BTPokemonListTableViewController.h"
#import "BTPokemon.h"
#import "BTPokemonDetailViewController.h"
#import "PokeDex-Swift.h"

@interface BTPokemonListTableViewController ()

@end

@implementation BTPokemonListTableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self updateViews];
}

#pragma mark - Functions
-(void)updateViews {
    
    [PokemonAPI.sharedController fetchAllPokemonsWithCompletion:^(NSArray<BTPokemon *> * pokemon, NSError * error) {
        
        if (pokemon) {
            self.arrayOfPokemonNames = pokemon;
            NSLog(@"%@",pokemon);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Unable to load pokemon.");
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayOfPokemonNames.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    BTPokemon *pokemon = self.arrayOfPokemonNames[indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetail"]) {
        BTPokemonDetailViewController *destinationVC = (BTPokemonDetailViewController *)segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        BTPokemon *selectedPokemon = self.arrayOfPokemonNames[selectedIndexPath.row];

        [PokemonAPI.sharedController fillInDetailsFor:selectedPokemon];

        destinationVC.pokemon = selectedPokemon;
    }
}

@end
