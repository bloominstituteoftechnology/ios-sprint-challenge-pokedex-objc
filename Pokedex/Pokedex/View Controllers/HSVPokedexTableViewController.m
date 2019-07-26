//
//  HSVPokedexTableViewController.m
//  Pokedex
//
//  Created by Hector Steven on 7/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "Pokedex-Swift.h"
#import "HSVPokedexTableViewController.h"
#import "HSVPokemonViewController.h"
#import "HSVPokemon.h"


@interface HSVPokedexTableViewController ()

@property (nonatomic) NSArray<HSVPokemon*> *pokedex;

@end

@implementation HSVPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	
	[[HSVPokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<HSVPokemon *> * _Nullable pokedex, NSError * _Nullable error) {

		if (error){
			NSLog(@"error: %@", error);
		}
		
		self.pokedex = pokedex;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
		
	}];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.pokedex count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
	cell.textLabel.text = self.pokedex[indexPath.row].name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"PokemonSegue"]) {
		HSVPokemonViewController *vc = (HSVPokemonViewController *) segue.destinationViewController;
		NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
		HSVPokemon *pokemon = self.pokedex[indexPath.row];
		vc.pokemon = pokemon;
		
		[[HSVPokemonAPI sharedController] fillInDetailsFor:pokemon];
	}
	
}


@end
