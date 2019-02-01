//
//  JWPokemon.m
//  Pokedex-ObjC
//
//  Created by Jerrick Warren on 2/1/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

#import "JWPokemon.h"

@implementation JWPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                   abilities:(NSString *)abilities
                      sprite:(NSURL *)sprite
{
    self = [super init];
    if (self) {
        _name        = [ name copy];
        _identifer   = [ identifier copy];
        _abilities   = [ abilities copy];
        _sprite      = [ sprite copy];
    
    }
    return self;
}



@end
