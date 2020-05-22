//
//  OTKPokemon.m
//  Pokedex
//
//  Created by Tobi Kuyoro on 22/05/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

#import "OTKPokemon.h"

@implementation OTKPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _name = dictionary[@"name"];
        NSString *urlString = dictionary[@"url"];
        _url = [[NSURL alloc] initWithString:urlString];
    }

    return self;
}

@end
