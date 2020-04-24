//
//  SAHPokemon.m
//  Pokedex-Obj-C
//
//  Created by scott harris on 4/24/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHPokemon.h"

@implementation SAHPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        
    }
    
    return self;
}

@end
