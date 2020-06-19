//
//  HAOPokemonTableViewController.m
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPokemonTableViewController.h"
#import "HAOPokemonDetailViewController.h"
#import "HAOPokemon.h"

#import "Pokedex_Objc-Swift.h"

@interface HAOPokemonTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray<HAOPokemon *> *pokemon;

@end

@implementation HAOPokemonTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self updateViews];
}

- (void)updateViews
{
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<HAOPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to fetch pokemon with error: %@", error);
            return;
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Pokemon array was nil");
            return;
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.pokemon[indexPath.row].name capitalizedString];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PokemonDetailSegue"]) {
        HAOPokemonDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        detailVC.pokemon = self.pokemon[indexPath.row];
    }
}

@end
