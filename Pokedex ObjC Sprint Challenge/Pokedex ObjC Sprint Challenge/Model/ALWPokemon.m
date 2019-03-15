//
//  ALWPokemon.m
//  Pokedex ObjC Sprint Challenge
//
//  Created by Audrey Welch on 3/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

#import "ALWPokemon.h"

@implementation ALWPokemon

- (instancetype)initWithName:(NSString *)name pokemonID:(nullable NSString *)pokemonID abilities:(nullable NSArray *)abilities sprite:(nullable NSString *)sprite {
    
    self = [super init];
    if (self != nil) {
        _name = [name copy];
        _pokemonID = [pokemonID copy];
        _abilities = [abilities copy];
        _sprite = [sprite copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *pokemonID = dictionary[@"id"];
    NSString *sprite = dictionary[@"front_default"];
    
    NSArray *abilitiesInfo = dictionary[@"abilities"];
    
    // KVC
    // Get value for the keypath ability.name - valueForKey "ability", and everything that that produces, it will call valueForKey "name"
    NSArray *names = [abilitiesInfo valueForKeyPath:@"ability.name"];
    _abilities = names;
    
    
    if (!name || !pokemonID || !_abilities || !sprite) {
        return nil;
    }
    return [self initWithName:name pokemonID:pokemonID abilities: _abilities sprite:sprite];
}

@end
