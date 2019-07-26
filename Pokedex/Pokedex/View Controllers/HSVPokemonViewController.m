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
#import <UIKit/UIKit.h>

void *KVOContext = &KVOContext;

@interface HSVPokemonViewController ()
@end

@implementation HSVPokemonViewController

- (void)viewWillDisappear:(BOOL)animated {
	
}

-(void)dealloc{
	[self.pokemon removeObserver:self forKeyPath:@"abilities"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	if (self.pokemon) {
		NSLog(@"found Pokemon");
		[self.pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
		
		[[HSVPokemonAPI sharedController] fillInDetailsFor:self.pokemon];
		
		
	}
	
}

- (void)setupView{
	
	if(self.pokemon){
		self.nameLabel.text = [self.pokemon.name uppercaseString];
		self.idLabel.text = [[NSString alloc] initWithFormat:@"ID: %@", self.pokemon.identifier];
		
		NSString *abilitiesStr = [self.pokemon.abilities componentsJoinedByString:@", "];
		NSLog(@"%@", self.pokemon.abilities);
		self.abilitiesLabel.text =  abilitiesStr;
		[self fetchSetImage];
	}else {
		NSLog(@"missing pokemon");
	}
	
}

- (void)fetchSetImage{
	NSLog(@"%@", self.pokemon.sprite);
	NSURL *url = [[NSURL alloc] initWithString:self.pokemon.sprite];
	[[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (error){
			NSLog(@"error getting image: %@", error);
			
		}
		
		if (data){
			UIImage *image = [[UIImage alloc] initWithData:data];
			dispatch_async(dispatch_get_main_queue(), ^{
				self.imageView.image = image;
			});
			
		}
		
	}] resume];
	
	
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
	if (context == KVOContext) {
		NSLog(@"abilities changed!!!");
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self setupView];
			
		});
		

	}else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}



@end
