//
//  ALWPokemon.m
//  Pokedex ObjC Sprint Challenge
//
//  Created by Audrey Welch on 3/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

#import "ALWPokemon.h"

#define CheckClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil; }

@implementation ALWPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        NSString *name = dictionary[@"name"];
        CheckClass(name, NSString);
        
        NSInteger pokemonID = dictionary[@"id"];
        
        // Save values I've pulled out and put them into the instance variables
        _name = name;
        _pokemonID = pokemonID;
        
        NSString *sprite = [dictionary valueForKeyPath: @"sprites.front_default"];
        
        NSArray *abilitiesInfo = dictionary[@"abilities"];
        
        // KVC: Get value for the keypath ability.name - valueForKey "ability", and everything that that produces, it will call valueForKey "name"
        NSArray *names = [abilitiesInfo valueForKeyPath:@"ability.name"];
        
        _abilities = names;
        _sprite = sprite;
    }
    return self;
}


@end
