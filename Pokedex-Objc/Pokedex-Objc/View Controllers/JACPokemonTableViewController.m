//
//  JACPokemonTableViewController.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import "JACPokemonTableViewController.h"
#import "Pokedex_Objc-Swift.h"
#import "JACPokemon.h"

@interface JACPokemonTableViewController ()
@property PokemonController *controller;
@property NSArray<JACPokemon *> *pokemon;
@end

@implementation JACPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _controller = [[PokemonController alloc] init];
        [_controller fetchAllPokemonWithCompletion:^(NSArray<JACPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
            if (error) { return; }
            
            self.pokemon = pokemon;
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.pokemon objectAtIndex:[indexPath row]].name capitalizedString];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
