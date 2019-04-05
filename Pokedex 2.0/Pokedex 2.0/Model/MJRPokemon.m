//
//  MJRPokemon.m
//  Pokedex 2.0
//
//  Created by Moses Robinson on 4/5/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

#import "MJRPokemon.h"

@implementation MJRPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"id"];
    
    NSString *spriteString = dictionary[@"sprites"][@"front_default"];
    NSURL *sprite = [NSURL URLWithString:spriteString];
    
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    
    NSArray *abilitiesDictionary = dictionary[@"abilities"];
    
    for (NSDictionary *abilityDictionary in abilitiesDictionary) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        
        [abilities addObject:ability];
    }
    
    return [self initWithName:name identifier:identifier abilities:abilities sprite:sprite];
}

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSArray *)abilities sprite:(NSURL *)sprite
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _abilities = [abilities copy];
        _sprite = [sprite copy];
    }
    return self;
}

@end
