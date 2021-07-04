//
//  GLIPokemon.m
//  Pokedex
//
//  Created by Julian A. Fordyce on 4/12/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

#import "GLIPokemon.h"

@implementation GLIPokemon


- (instancetype)initWithName:(NSString *)name id:(NSInteger)identifier spritesURL:(NSString *)spritesURL abilities:(NSString *)abilities
{
    self = [super init];
    if (self) {
        _name = name;
        _identifier = identifier;
        _spritesURL = spritesURL;
        _abilities = abilities;
    }
    return self;
}


@end
