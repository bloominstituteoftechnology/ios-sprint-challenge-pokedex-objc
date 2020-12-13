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
        _name = name.copy;
        _identifier = nil;
        _abilities = nil;
        _spriteURL = @"";
    }
    return self;
}

- (void)updateWithIdentifier:(NSNumber *)anID
                   abilities:(NSString *)someAbilities
                   spriteURL:(NSString *)aURL
{
    self.identifier = anID;
    self.abilities = someAbilities.copy;
    self.spriteURL = aURL.copy;
}

@end
