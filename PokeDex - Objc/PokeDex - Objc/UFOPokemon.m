//
//  UFOPokemon.m
//  PokeDex - Objc
//
//  Created by Ufuk Türközü on 24.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import "UFOPokemon.h"

@implementation UFOPokemon

static NSString const *idKey = @"id";
static NSString const *nameKey = @"name";
static NSString const *abilitiesKey =  @"ability";
static NSString const *spritesKey = @"sprites";
static NSString const *frontDefKey = @"front_default";

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        _identifier = dictionary[idKey];
        _name = dictionary[nameKey];
        _abilities = dictionary[abilitiesKey];
        
        NSDictionary *sprites = dictionary[spritesKey];
        NSString *spriteString = sprites[frontDefKey];
        _sprite = [NSURL URLWithString:spriteString];
    }
    return self;
}

@end
