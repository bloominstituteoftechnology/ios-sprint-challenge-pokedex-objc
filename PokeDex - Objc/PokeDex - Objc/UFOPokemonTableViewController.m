//
//  UFOPokemonTableViewController.m
//  PokeDex - Objc
//
//  Created by Ufuk Türközü on 24.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import "UFOPokemonTableViewController.h"
#import "UFOPokemon.h"
#import "PokeDex-Swift.h"

@interface UFOPokemonTableViewController ()

@property (nonatomic, strong) APIController *apiController;
@property NSArray<UFOPokemon *> *pokeList;

@end

@implementation UFOPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apiController = [APIController sharedController];
    _pokeList = [NSMutableArray new];
    [self.apiController fetchAllPokemonWithCompletion:^(NSArray<UFOPokemon *> * data, NSError * error) {
        self.pokeList = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    UFOPokemon *pokemon = self.pokeList[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    //cell.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:pokemon.sprite]];
    return cell;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetailSegue"]) {
        PokemonDetailViewController *destinationVC = (PokemonDetailViewController *) segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        UFOPokemon *pokemon = self.pokeList[indexPath.row];
        destinationVC.pokemon = pokemon;
    }
}

@end
