//
//  REPPokedexViewController.m
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPPokedexViewController.h"
#import "REPPokemonController.h"

@interface REPPokedexViewController ()

@property (nonatomic) REPPokemonController *pokeController;

@end

@implementation REPPokedexViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.pokeController = [[REPPokemonController alloc] initWithLoadCompletionHandler:^(NSError *error) {
		NSLog(@"load finished: %@", self.pokeController.pokemans);
	}];

}


@end
