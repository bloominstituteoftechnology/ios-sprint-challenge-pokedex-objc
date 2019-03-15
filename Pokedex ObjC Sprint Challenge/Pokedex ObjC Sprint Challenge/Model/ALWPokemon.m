//
//  ALWPokemon.m
//  Pokedex ObjC Sprint Challenge
//
//  Created by Audrey Welch on 3/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

#import "ALWPokemon.h"

@implementation ALWPokemon

- (instancetype)initWithName:(NSString *)name pokemonID:(NSInteger)pokemonID abilities:(NSString *)abilities sprite:(NSString *)sprite {
    
    self = [super init];
    if (self != nil) {
        _name = [name copy];
        _pokemonID = pokemonID;
        _abilities = [abilities copy];
        _sprite = [sprite copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *pokemonID = dictionary[@"id"];
    NSString *abilities = dictionary[@"name"];
    NSString *sprite = dictionary[@"front_default"];
    
    if (!name || !pokemonID || !abilities || !sprite) {
        return nil;
    }
    return [self initWithName:name pokemonID:pokemonID abilities:abilities sprite:sprite];
}

@end
