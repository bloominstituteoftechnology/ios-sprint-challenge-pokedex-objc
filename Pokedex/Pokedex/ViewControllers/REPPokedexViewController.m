//
//  REPPokedexViewController.m
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPPokedexViewController.h"
#import "REPPokemonController.h"
#import "REPPokeman.h"
#import "Pokedex-Swift.h"

@interface REPPokedexViewController ()

@property (nonatomic) REPPokemonController *pokeController;

@end

@implementation REPPokedexViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.pokeController = [[REPPokemonController alloc] initWithLoadCompletionHandler:^(NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^(void){
			[self.tableView reloadData];
		});
	}];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"ShowPokemonInfo"]) {
		PokemonInfoDetailVC *detailVC = segue.destinationViewController;
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		REPPokeman *pokemon = self.pokeController.pokemans[indexPath.row];
		detailVC.pokeman = pokemon;
	}
}


// MARK: - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.pokeController.pokemans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];

	REPPokeman *pokemon = self.pokeController.pokemans[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%03lu - %@", pokemon.identifier, pokemon.name];

	return cell;
}

@end
