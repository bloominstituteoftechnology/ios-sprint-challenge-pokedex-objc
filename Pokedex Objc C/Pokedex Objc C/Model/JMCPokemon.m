//
//  JMCPokemon.m
//  Pokedex Objc C
//
//  Created by Jarren Campos on 8/14/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

#import "JMCPokemon.h"

@implementation JMCPokemon

- (nonnull instancetype)initWithName:(NSString *)name sprite:(NSString *)sprite url:(NSString *)url id:(int)id abilities:(NSArray *)abilities
{
    if (self = [super init]) {
        _name = [name copy];
        _sprite = [sprite copy];
        _url = [url copy];
        _id = id;
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [NSString stringWithFormat:@"%@", dictionary[@"name"]];
    NSString *url = [NSString stringWithFormat:@"%@", dictionary[@"url"]];
    return [self initWithName:name sprite:NULL url:url id:NULL abilities:NULL];
}

@end
