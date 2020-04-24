//
//  EPWPokemon.m
//  Pokedex
//
//  Created by Elizabeth Wingate on 4/24/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import "EPWPokemon.h"

@implementation EPWPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        NSURL *urlFromString = dictionary[@"url"];
        _url = urlFromString;
    }
    return self;
}

@end
