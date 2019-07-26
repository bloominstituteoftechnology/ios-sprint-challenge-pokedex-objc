//
//  HSVPokemon.m
//  Pokedex
//
//  Created by Hector Steven on 7/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVPokemon.h"

@implementation HSVPokemon


- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier
{
	self = [super init];
	if (self) {
		_name = name;
		_identifier = identifier;
		
		
	}
	return self;
}

@end
