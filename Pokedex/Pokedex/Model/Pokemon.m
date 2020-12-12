//
//  Pokemon.m
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
        _identifier = nil;
        _abilities = nil;
        _spriteURL = nil;
    }
    return self;
}

@end
