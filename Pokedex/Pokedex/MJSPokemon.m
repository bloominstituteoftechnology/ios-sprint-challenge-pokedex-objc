//
//  MJSPokemon.m
//  Pokedex
//
//  Created by Michael Stoffer on 11/23/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

#import "MJSPokemon.h"

@implementation MJSPokemon

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
