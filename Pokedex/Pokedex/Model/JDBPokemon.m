//
//  JDBPokemon.m
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import "JDBPokemon.h"
#import "JDBAbility.h"

#define CheckClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil; }

@implementation JDBPokemon

- (instancetype)initWithDictionary:(NSDictionary *)allDictionary {
    CheckClass(allDictionary, NSDictionary);
    
    self = [super init];
    if (self) {
        NSDictionary *dictionary = allDictionary;
        
        NSString *name = dictionary[@"name"];
        CheckClass(name, NSString);
        
        NSString *url = dictionary[@"url"];
        //CheckClass(url, NSString);
        
        NSInteger idNumber = (long)dictionary[@"id"];
        
        _name = name;
        _url = url;
        _idNumber = idNumber;

        NSString *sprite = [dictionary valueForKeyPath:@"sprites.front_default"];

        _sprite = sprite;

        NSArray *abilityDefinitions = dictionary[@"abilities"];
        NSArray *abilityNames = [abilityDefinitions valueForKeyPath:@"ability.name"];
        _abilities = abilityNames;
    }
    return self;
}

@end
