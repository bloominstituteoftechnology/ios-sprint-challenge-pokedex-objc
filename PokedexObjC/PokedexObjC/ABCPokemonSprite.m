//
//  ABCPokemonSprite.m
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import "ABCPokemonSprite.h"

@implementation ABCPokemonSprite

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _spriteURL = dictionary[@"front_default"];
    }
    return self;
}

@end
