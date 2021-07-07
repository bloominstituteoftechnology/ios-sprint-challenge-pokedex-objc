//
//  JTMPokemon.m
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/12/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import "JTMPokemon.h"

@implementation JTMPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier sprite:(NSURL *)sprite abilities:(NSArray<NSString *> *)abilities
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _sprite = [sprite copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"identifier"];
    NSURL *sprite = dictionary[@"sprite"];
    NSArray<NSString *> *abilities = dictionary[@"abilities"];
    
    return [self initWithName:name identifier:identifier sprite:sprite abilities:abilities];
}

@end
