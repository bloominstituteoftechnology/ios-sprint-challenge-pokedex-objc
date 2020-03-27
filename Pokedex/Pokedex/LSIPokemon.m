//
//  LSIPokemon.m
//  Pokedex
//
//  Created by Alexander Supe on 27.03.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _urlString = dictionary[@"url"];
        _name = dictionary[@"name"];
    }
    return self;
}

@end
