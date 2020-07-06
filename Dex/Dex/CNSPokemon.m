//
//  CNSPokemon.m
//  Dex
//
//  Created by Ezra Black on 6/19/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

#import "CNSPokemon.h"

@implementation CNSPokemon

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
    return [self initWithName:name url:url id:0 abilities:NULL sprites:NULL];
}

@end
