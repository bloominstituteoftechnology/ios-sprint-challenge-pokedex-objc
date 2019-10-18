//
//  JSPokeDetailsVC.m
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import "JSPokeDetailsVC.h"
#import "Pokedex_C-Swift.h"
#import "JSPokeDetails.h"

@interface JSPokeDetailsVC ()

@property (weak, nonatomic) IBOutlet UIImageView *pokeImgView;
@property (weak, nonatomic) IBOutlet UILabel *idLbl;
@property (weak, nonatomic) IBOutlet UILabel *heightLbl;
@property (weak, nonatomic) IBOutlet UILabel *weightLbl;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;

- (void)updateViewsWithPokemon:(JSPokeDetails *)pokemon;
- (void)getImageFromUrl:(NSURL *)url;
- (double)convertWeightFromHexagram:(double)hexWeight;

@end

@implementation JSPokeDetailsVC

// MARK: - IBOutlets


// MARK: - Properties


// MARK: - Life Cycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.pokecontroller getPokeDetailsFrom:self.pokeName completion:^(JSPokeDetails * _Nullable details) {
		if (details) {
			[self updateViewsWithPokemon:details];
		}
	}];
	[self.descriptionLbl setHidden:true];
}

// MARK: - IBActions


// MARK: - Helpers

- (void)updateViewsWithPokemon:(JSPokeDetails *)pokemon {
	dispatch_async(dispatch_get_main_queue(), ^{
		self.title = [pokemon.name capitalizedString];
		self.idLbl.text = [NSString stringWithFormat:@"ID: %d", pokemon.id];
		self.heightLbl.text = [NSString stringWithFormat:@"Height: %.2f", [self convertHeightFromDecimetres:pokemon.height]];
		self.weightLbl.text = [NSString stringWithFormat:@"Weight: %.2f", [self convertWeightFromHexagram:pokemon.weight]];
		
		NSString *abilities = [pokemon.abilities componentsJoinedByString:@", "];
		self.abilitiesLbl.text = [NSString stringWithFormat:@"Abilities: %@", [abilities capitalizedString]];
		//	self.description.text = pokemon.description;
	});
	[self getImageFromUrl:pokemon.imageUrl];
}

- (void)getImageFromUrl:(NSURL *)url {
	dispatch_async(dispatch_get_global_queue(0,0), ^{
		NSData *data = [[NSData alloc] initWithContentsOfURL: url];
		if ( data == nil )
        return;		dispatch_async(dispatch_get_main_queue(), ^{
			[self.pokeImgView setImage:[UIImage imageWithData: data]];
		});
	});
}

- (double)convertWeightFromHexagram:(double)hexWeight {
	const double HEX_CONVERSION = 0.220462;
	return hexWeight * HEX_CONVERSION;
}

- (double)convertHeightFromDecimetres:(double)deciHeight {
	const double DECI_CONVERSION = 0.328084;
	return deciHeight * DECI_CONVERSION;
}

@end
