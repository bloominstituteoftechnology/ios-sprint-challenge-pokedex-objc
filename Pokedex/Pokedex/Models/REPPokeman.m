//
//  REPPokeman.m
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPPokeman.h"

@implementation REPPokeman

- (NSString *)name {
	return [_name capitalizedString];
}

- (instancetype)initWithName:(NSString *)name infoURL:(NSURL *)url {
	if (self = [super init]) {
		_name = name;
		_pokeURL = url;

		_identifier = [[url lastPathComponent] integerValue];
	}
	return self;
}

+ (REPPokeman *)pokemonFromDictionary:(NSDictionary *)dictionary {
	NSString *name = dictionary[@"name"];
	NSURL *url = [NSURL URLWithString:dictionary[@"url"]];

	return [[REPPokeman alloc] initWithName:name infoURL:url];
}

@end
