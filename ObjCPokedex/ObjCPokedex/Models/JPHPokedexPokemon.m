//
//  JPHPokedexPokemon.m
//  ObjCPokedex
//
//  Created by Jerry haaser on 1/31/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

#import "JPHPokedexPokemon.h"

@implementation JPHPokedexPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];
    
    return [self initWithName:name url:url];
}

@end
