//
//  UFOPokemon.m
//  PokeDex - Objc
//
//  Created by Ufuk Türközü on 24.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import "UFOPokemon.h"

@implementation UFOPokemon

static NSString const *idKey = @"id";
static NSString const *nameKey = @"name";
static NSString const *abilitiesKey =  @"abilities";
static NSString const *abilityKey =  @"ability";
static NSString const *spritesKey = @"sprites";
static NSString const *frontDefKey = @"front_default";
static NSString const *urlKey = @"url";

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        _name = dictionary[nameKey];
        NSLog(@"Name: %@", _name);
        NSString *urlString = dictionary[urlKey];
        _url = [[NSURL alloc] initWithString:urlString];
    }
    return self;
}

@end
