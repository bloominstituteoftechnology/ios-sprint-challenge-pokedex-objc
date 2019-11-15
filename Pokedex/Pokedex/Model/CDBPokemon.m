//
//  CDBPokemon.m
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import "CDBPokemon.h"

@implementation CDBPokemon

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Identifier: %@", self.name, self.identifier];
}

@end
