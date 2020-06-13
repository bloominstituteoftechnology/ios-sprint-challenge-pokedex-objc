//
//  JAGPokemon.m
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "JAGPokemon.h"

@implementation JAGPokemon

- (instancetype)initWithName:(NSString *)aName
               andIdentifier:(NSInteger)anIdentifier
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

@end
