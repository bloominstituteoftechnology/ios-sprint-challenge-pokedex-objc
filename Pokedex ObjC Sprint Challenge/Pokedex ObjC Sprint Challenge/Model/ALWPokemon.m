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

//- (instancetype)initWithName:(NSString *)name pokemonID:(nullable NSString *)pokemonID abilities:(nullable NSArray *)abilities sprite:(nullable NSString *)sprite {
//
//    self = [super init];
//    if (self != nil) {
//        _name = [name copy];
//        _pokemonID = [pokemonID copy];
//        _abilities = [abilities copy];
//        _sprite = [sprite copy];
//    }
//    return self;
//}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        NSString *name = dictionary[@"name"];
        CheckClass(name, NSString);
        
        NSString *pokemonID = dictionary[@"id"];
        
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



//- (instancetype)initWithJSON:(id)json {
//    //if ([json isKindOfClass:[NSDictionary class]] == NO) { return nil; }
//    CheckClass(json, NSDictionary);
//
//    self = [super init];
//    if (self) {
//
//        NSDictionary *dict = json;
//
//        NSString *name = dict[@"name"];
//        CheckClass(name, NSString);
//
//        NSString *pokemonID = dict[@"id"];
//        CheckClass(pokemonID, NSString);
//    }
//}

@end
