//
//  JSPokeLink.m
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import "JSPokeLink.h"

@implementation JSPokeLink

- (instancetype)initWithDict:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		NSString *urlString = [dict[@"url"] copy];
		
		_name = [dict[@"name"] copy];
		_url = [[NSURL alloc] initWithString:urlString];
	}
	return self;
}

@end
