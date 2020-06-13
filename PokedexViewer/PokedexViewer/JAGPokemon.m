//
//  JAGPokemon.m
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "JAGPokemon.h"

@implementation JAGPokemon

- (instancetype)initWithName:(NSString *)name andURLString:(NSString *)pokemonURLString
{
    if (self = [super init]) {
        _name = name;
        _pokemonURLasString = pokemonURLString;
    }
    return self;
}


- (instancetype)initWithName:(NSString *)aName
               andIdentifier:(int)anIdentifier
                  withSprite:(NSString *)aSpriteURLString
                andAbilities:(NSArray *)abilities
{
    if (self = [super init]) {
        _name = aName;
        _identifier = anIdentifier;
        _spriteURLString = aSpriteURLString;
        _abilities = abilities;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    int identifier = dictionary[@"id"];
    NSString *spriteURLString = dictionary[@"sprites"];
    NSArray *abilities = dictionary[@"abilities"];

    // Failable initializer will return nil if any of these required
    // properties is missing. (It is risky to make assumptions about data)
//    if (!name || !birthYear || !heightString || !eyeColor) {
//        return nil;
//    }
    return [self initWithName:name andIdentifier:identifier withSprite:spriteURLString andAbilities:abilities];
}

@end
