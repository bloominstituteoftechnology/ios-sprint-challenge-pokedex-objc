//
//  JSPokeDetails.m
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import "JSPokeDetails.h"

@implementation JSPokeDetails

- (instancetype)initWithDict:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		NSArray *abilitiesArray = dict[@"abilities"];
		NSMutableArray *abilities = [@[] mutableCopy];
		
		_id = [dict[@"id"] intValue];
		_name = [dict[@"name"] copy];
		_height = [dict[@"height"] doubleValue];
		_weight = [dict[@"weight"] doubleValue];
		
		for (NSDictionary *dict in abilitiesArray) {
			NSDictionary *abilityDict = dict[@"ability"];
			NSString *ability = [abilityDict[@"name"] copy];
			[abilities addObject:ability];
		}
		_abilities = [abilities copy];
	}
	return self;
}

@end
