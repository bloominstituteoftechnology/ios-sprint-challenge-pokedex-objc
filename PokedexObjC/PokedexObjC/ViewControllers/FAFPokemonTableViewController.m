//
//  FAFPokemonTableViewController.m
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import "FAFPokemonTableViewController.h"
#import "PokedexObjC-Swift.h"
#import "FAFPokemon.h"
#import "FAFPokemonController.h"

@interface FAFPokemonTableViewController ()
    
    @property (nonatomic, strong, readwrite) NSMutableArray<FAFPokemon *> *internalPokemons;

@end

@implementation FAFPokemonTableViewController
    
    
- (instancetype)initWithCoder:(NSCoder *)aDecoder
    {
        self = [super initWithCoder:aDecoder];
        if (self) {
            [[FAFPokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<FAFPokemon *> * pokemons, NSError * error) {
                self->_internalPokemons = [NSMutableArray arrayWithArray:pokemons];
            }];
        }
        return self;
    }
    
    
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            [[FAFPokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<FAFPokemon *> * pokemons, NSError * error) {
                self->_internalPokemons = [NSMutableArray arrayWithArray:pokemons];
            }];
        }
        return self;
    }

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.internalPokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    FAFPokemon *pokemon = [self.internalPokemons objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
