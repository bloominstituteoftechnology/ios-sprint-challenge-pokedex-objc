//
//  DODPokemon.m
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODPokemon.h"

@implementation DODPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier sprite:(NSString *)sprite abilities:(NSString *)abilities
{
    if (self = [super init]) {
        _name = name;
        _identifier = identifier;
        _sprite = sprite;
        _abilities = abilities;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"identifier"];
    NSString *sprite = dictionary[@"sprite"];
    NSString *abilities = dictionary[@"abilities"];
    
    return [self initWithName:name identifier:identifier sprite:sprite abilities:abilities];
}

@end
