//
//  OSIPokemonTableViewController.m
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import "OSIPokemonTableViewController.h"
#import "OSIPokemonController.h"
#import "OSIPokemon.h"
#import "OSIPokemonName.h"
#import "OSIPokemonDetailsViewController.h"
#import "Sprint12-Swift.h"

@interface OSIPokemonTableViewController ()
@property OSIPokemonController *osiPokemonController;
@property OSIPokemonName *osiPokemonName;
@property OSIPokemon *osiPokemon;
@end

@implementation OSIPokemonTableViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        _osiPokemonController = [[OSIPokemonController alloc] init];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        _osiPokemonController = [[OSIPokemonController alloc] init];
        
    }
    return self;
}

static NSString * const reuseIdentifier = @"pokemonCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.osiPokemonController fetchPokemonName:^(OSIPokemonName *pokemon, NSError *error) {
        self.osiPokemonName = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.osiPokemonName.names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.textLabel.text = [self.osiPokemonName.names[indexPath.row] capitalizedString];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([segue.identifier isEqualToString:@"pokemonDetails"]) {
        OSIPokemonDetailsViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *pokemonURL = self.osiPokemonName.url[indexPath.row];
        destinationVC.pokemonURL = pokemonURL;
    }
    
}



@end
