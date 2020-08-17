//
//  MKMPokemon.m
//  Pokedex-objc
//
//  Created by Matthew Martindale on 8/16/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "MKMPokemon.h"

@implementation MKMPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(int)identifier
                         url:(NSString *)url
                   abilities:(NSString *)abilities
                     sprites:(NSString *)sprites
{
    if (self = [super init]) {
        _name = name.copy;
        _identifier = identifier;
        _url = url.copy;
        _abilities = abilities.copy;
        _sprites = sprites.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [dictionary objectForKey:@"name"];
    if (![name isKindOfClass:NSString.class]) return nil;
    
    NSString *url = [dictionary objectForKey:@"url"];
    if (![url isKindOfClass:NSString.class]) return nil;
    
    return [self initWithName:name
                   identifier:0
                          url:url
                    abilities:nil
                      sprites:nil];
}

@end
