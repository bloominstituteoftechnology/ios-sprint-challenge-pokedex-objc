//
//  MainTableViewController.m
//  PokeObjC
//
//  Created by Nick Nguyen on 4/24/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "MainTableViewController.h"
#import "NPTPokemon.h"
#import "LSILog.h"
#import "PokeObjC-Swift.h"

@interface MainTableViewController ()

@property (nonnull, nonatomic) NSArray<NPTPokemon *> *pokemons;


@end

@implementation MainTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemons = @[];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<NPTPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        self.pokemons = [pokemons sortedArrayUsingDescriptors:sortDescriptors];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    NPTPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  
    
    if ([segue.identifier isEqualToString:@"MainToDetail"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = self.pokemons[indexPath.row];
    }
}

@end
