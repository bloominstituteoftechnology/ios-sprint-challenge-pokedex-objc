//
//  NELPokemon.m
//  Pokedex
//
//  Created by Nelson Gonzalez on 4/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

#import "NELPokemon.h"

@interface NELPokemon ()

@property (nonatomic, nullable, copy, readwrite) NSMutableArray<NSString *> *internalAbilities;

@end

@implementation NELPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _pokeName = dictionary[@"name"];
        _pokeUrl = dictionary[@"url"];
        _pokeId = nil;
        _pokeFrontDefaultUrl = nil;
        _pokeAbilities = nil;
        
    }
    return self;
}

- (void)fillPokeDictionary:(NSDictionary *)dictionary
{
    _pokeId = dictionary[@"id"];
    
    NSDictionary *spritesDict = dictionary[@"sprites"];
    _pokeFrontDefaultUrl = spritesDict[@"font_default"];
    
    NSArray *abilities = dictionary[@"abilities"];
    for (NSDictionary *ability in abilities) {
        NSString *name = ability[@"name"];
        [self.internalAbilities addObject: name];
    }
    _pokeAbilities = self.internalAbilities;
}

@end

