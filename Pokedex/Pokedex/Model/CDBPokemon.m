//
//  CDBPokemon.m
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import "CDBPokemon.h"

@implementation CDBPokemon

- (instancetype) initWithName:(NSString *)name withID:(NSNumber *)identifier withSprites:(NSDictionary *)sprites withAbilities:(NSArray *)abilities {
    if (self = [super init]) {
        _name = [name copy];
        _identifier = [identifier copy];
        _sprites = [sprites copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"id"];
    NSString *sprites = dictionary[@"sprites"];
    NSString *abilities = dictionary[@"abilities"];
    
    return [self initWithName:name withID:identifier withSprites:sprites withAbilities:abilities];
}

@end
