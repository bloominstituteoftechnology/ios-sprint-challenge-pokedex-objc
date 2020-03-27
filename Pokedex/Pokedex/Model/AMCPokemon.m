//
//  AMCPokemon.m
//  Pokedex
//
//  Created by Aaron Cleveland on 3/27/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

#import "AMCPokemon.h"

@implementation AMCPokemon

- (nonnull instancetype)initWithName:(nullable NSString *)name
                                 url:(nullable NSString *)url
                                  id:(int)id
                           abilities:(nullable NSArray *)abilities
                             sprites:(nullable NSString *)sprites
{
    if (self = [super init]) {
        _id = id;
        _name = [name copy];
        _url = [url copy];
        _abilities = [abilities copy];
        _sprites = [sprites copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [NSString stringWithFormat:@"%@", dictionary[@"name"]];
    NSString *url = [NSString stringWithFormat:@"%@", dictionary[@"url"]];
    return [self initWithName:name url:url id:NULL abilities:NULL sprites:NULL];
}

@end
