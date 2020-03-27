//
//  CDBPokemonAbility.m
//  Pokedex
//
//  Created by Ciara Beitel on 3/27/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import "CDBPokemonAbility.h"

@implementation CDBPokemonAbility

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"ability"][@"name"];
    if (!name) { return nil; }
    return [self initWithName:name];
}

@end
