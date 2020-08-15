//
//  Pokemon.m
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifer abilities:(NSArray<NSString *> *)abilites
{
    self = [super init];
    if (self) {
        _name = name;
        _identifier = identifer;
        _abilites = abilites;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"id"];

    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray<NSString *> alloc] init];

    for (NSDictionary *ability in abilitiesArray) {
        NSString *abilityName = ability[@"name"];
        [abilities addObject:abilityName];
    }

    self = [self initWithName:name identifier:identifier abilities:abilities];
    return self;
}

@end
