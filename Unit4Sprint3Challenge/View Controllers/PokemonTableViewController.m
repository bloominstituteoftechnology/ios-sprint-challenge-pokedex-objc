//
//  PokemonTableViewController.m
//  Unit4Sprint3Challenge
//
//  Created by Jon Bash on 2020-01-31.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "Unit4Sprint3Challenge-Swift.h"
#import "JBPokemon.h"

@interface PokemonTableViewController ()

@property (nonnull, nonatomic) NSArray<JBPokemon *> *allPokemon;

@end

@implementation PokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _allPokemon = @[];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<JBPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error fetching pokemon: %@", error);
        }
        self.allPokemon = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell"
                                                            forIndexPath:indexPath];

    cell.textLabel.text = self.allPokemon[indexPath.row].name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PokemonDetailViewController *detailVC = segue.destinationViewController;
}

@end
