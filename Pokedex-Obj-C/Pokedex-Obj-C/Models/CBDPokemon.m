//
//  CBDPokemon.m
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "CBDPokemon.h"

@implementation CBDPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *)identifier
                   spriteURL:(NSString *)spriteURL
                   abilities:(NSArray<NSString *> *)abilities {
    self = [super init];
    if (!self) { return nil; }
    _name = name;
    _identifier = identifier;
    _spritURL = spriteURL;
    _abilities = abilities;
    return self;
}

@end
