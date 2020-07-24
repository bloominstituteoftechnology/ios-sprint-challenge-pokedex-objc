//
//  PokedexTableViewController.m
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"

@interface PokedexTableViewController ()

@property PokemonAPIClient *apiClient;
@property NSArray<Pokemon *> *pokemon;

- (void)setUp;
@end

@implementation PokedexTableViewController

//MARK: - Inits

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if(!self) {
        return nil;
    }
    
    [self setUp];
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(!self) {
        return nil;
    }
    
    [self setUp];
    return self;
}

- (void)setUp {
    _apiClient = [[PokemonAPIClient alloc] init];
}

//MARK: -Lifecylce

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.apiClient fetchSortedPokemonWithCompletion:^(NSArray<Pokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        
        if (error)
            
        {
            NSLog(@"%@", error);
        }
        
        else if (pokemon)
            
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.pokemon = pokemon;
                
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source

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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}


@end
