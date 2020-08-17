//
//  SMAPokemon.m
//  PokedexObjC
//
//  Created by Sean Acres on 8/16/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

#import "SMAPokemon.h"

@implementation SMAPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *)identifier
                   abilities:(NSArray *)abilities
                   urlString:(NSString *)urlString
{
    if (self = [super init]) {
        _name = name.copy;
        _identifier = identifier.copy;
        _abilities = abilities.copy;
        _urlString = urlString.copy;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [dictionary objectForKey:@"name"];
    NSString *urlString = [dictionary objectForKey:@"url"];
    
    return [self initWithName:name identifier:nil abilities:nil urlString:urlString];
}

@end
