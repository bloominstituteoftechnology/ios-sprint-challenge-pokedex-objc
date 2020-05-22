//
//  PokedexTableViewController.m
//  Pokedex
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "Pokedex-Swift.h"
#import "Pokemon.h"

@interface PokedexTableViewController ()

@property PokeApiClient *apiClient;
@property NSArray<Pokemon *> *pokemon;

- (void)setUp;

@end

@implementation PokedexTableViewController

// MARK: - Init

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder: coder];
    if (!self) { return nil; }
    
    [self setUp];
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) { return nil; }
    
    [self setUp];
    
    return self;
}

- (void)setUp {
    _apiClient = [[PokeApiClient alloc] init];
}

// MARK: - View Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.apiClient fetchSortedPokemonWithCompletion:^(NSArray<Pokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else if (pokemon) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pokemon = pokemon;
                [self.tableView reloadData];
            });
        }
    }];
}

// MARK: - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    Pokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}

// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonSegue"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        Pokemon *pokemon = self.pokemon[self.tableView.indexPathForSelectedRow.row];
        [self.apiClient fetchDetailsFor:pokemon];
        detailVC.pokemon = pokemon;
        detailVC.apiClient = self.apiClient;
    }
}


@end
