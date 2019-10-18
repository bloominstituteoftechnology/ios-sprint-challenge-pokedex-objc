//
//  BYPokemon.m
//  pokedex-objc
//
//  Created by Bradley Yin on 10/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import "BYPokemon.h"

@implementation BYPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _name = dictionary[@"name"];
        NSString *urlString = dictionary[@"url"];
        _url = [NSURL URLWithString:urlString];
    }
    return self;
}

@end
