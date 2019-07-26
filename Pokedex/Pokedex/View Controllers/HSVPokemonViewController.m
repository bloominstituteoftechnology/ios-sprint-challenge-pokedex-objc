//
//  HSVPokemonViewController.m
//  Pokedex
//
//  Created by Hector Steven on 7/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVPokemonViewController.h"
#import "HSVPokemon.h"
#import "Pokedex-Swift.h"


@interface HSVPokemonViewController ()



@end

@implementation HSVPokemonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[self setupView];
	
}

- (void)setupView{
	
	if(self.pokemon){
		self.nameLabel.text = [self.pokemon.name uppercaseString];
		self.idLabel.text = [[NSString alloc] initWithFormat:@"ID: %@", self.pokemon.identifier];
		
		NSString *abilitiesStr = [self.pokemon.abilities componentsJoinedByString:@", "];
		NSLog(@"%@", abilitiesStr);
		self.abilitiesLabel.text =  [self.pokemon.abilities componentsJoinedByString:@", "];;
		
	}else {
		NSLog(@"missing pokemon");
	}
	
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
	//obserce for abilities
}



@end
