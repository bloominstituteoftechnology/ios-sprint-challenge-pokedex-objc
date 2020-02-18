//
//  REPPokemonController.m
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPPokemonController.h"
#import "Pokedex-Swift.h"

@interface REPPokemonController ()

@end

@implementation REPPokemonController

- (instancetype)initWithLoadCompletionHandler:(REPLoadCompletionBlock)completion {
	if (self = [super init]) {
		_pokemans = @[];
		[self loadAllPokemonWithCompletion:completion];
	}
	return self;
}

- (void)loadAllPokemonWithCompletion:(REPLoadCompletionBlock)completion {
	[[PokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<REPPokeman *> *pokemans, NSError *error) {
		if (error) {
			NSLog(@"Error getting pokemon: %@", error);
			completion(error);
			return;
		}

		self.pokemans = pokemans;
		completion(nil);
	}];
}

@end
