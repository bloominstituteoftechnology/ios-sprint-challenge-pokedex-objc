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

- (instancetype)initWithJSON:(id)json {
    CheckClass(json, NSDictionary);
    
    self = [super init];
    if (self) {
        NSDictionary *dictionary = json;
        
        NSNumber *idNumber = dictionary[@"id"];
        CheckClass(idNumber, NSNumber);
        
        NSString *name = dictionary[@"name"];
        CheckClass(name, NSString);
        
//        NSDictionary *speciesInfo = dictionary[@"species"];
//        CheckClass(speciesInfo, NSDictionary);
//        NSString *speciesName = dictionary[@"name"];
//        CheckClass(speciesName, NSString);
        
        NSDictionary *spriteInfo = dictionary[@"sprites"];
        CheckClass(spriteInfo, NSDictionary);
        NSURL *sprite = dictionary[@"back_default"];
        CheckClass(sprite, NSURL);
        
        _idNumber = idNumber;
        _name = name;
        _sprite = sprite;
//        _speciesName = speciesName;
        
//        NSArray *moveInfo = dictionary[@"moves"];
//        NSArray *names = [moveInfo valueForKeyPath:@"move.name"];
//        _moves = names;
    }
    return self;
    
}

@end
