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
                         url:(NSString *)url
{
    if (self = [super init]) {
        _name = name.copy;
        _url = url.copy;
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
                          url:url];
}

@end
