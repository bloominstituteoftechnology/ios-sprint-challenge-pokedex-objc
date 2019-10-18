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

@property JSPokeDetails *pokemon;

- (void)updateViews;
- (void)getImageFromUrl:(NSURL *)url;
- (double)convertWeightFromHexagram:(double)hexWeight;

@end

@implementation JSPokeDetailsVC

// MARK: - IBOutlets


// MARK: - Properties

static void *detailsContext = &detailsContext;

// MARK: - Life Cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		_pokemon = [[JSPokeDetails alloc] init];
		[self addObserver:self forKeyPath:@"pokemon" options:NSKeyValueObservingOptionNew context:&detailsContext];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.pokecontroller getPokeDetailsFrom:self.pokeName completion:^(JSPokeDetails * _Nullable details) {
		if (details) {
			self.pokemon = details;
		}
	}];
	[self.descriptionLbl setHidden:true];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == detailsContext) {
		[self updateViews];
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"pokemon" context:detailsContext];
}

// MARK: - IBActions


// MARK: - Helpers

- (void)updateViews {
	if (self.pokemon) {
		dispatch_async(dispatch_get_main_queue(), ^{
			self.title = [self.pokemon.name capitalizedString];
			self.idLbl.text = [NSString stringWithFormat:@"%d", self.pokemon.id];
			self.heightLbl.text = [NSString stringWithFormat:@"%.2f", [self convertHeightFromDecimetres:self.pokemon.height]];
			self.weightLbl.text = [NSString stringWithFormat:@"%.2f", [self convertWeightFromHexagram:self.pokemon.weight]];
			
			NSString *abilities = [self.pokemon.abilities componentsJoinedByString:@", "];
			self.abilitiesLbl.text = [NSString stringWithFormat:@"%@", [abilities capitalizedString]];
			//	self.description.text = pokemon.description;
		});
		[self getImageFromUrl:self.pokemon.imageUrl];
	}
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
