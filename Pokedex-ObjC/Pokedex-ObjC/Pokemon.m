//
//  Pokemon.m
//  Pokedex-ObjC
//
//  Created by Fabiola S on 2/21/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (nonnull instancetype)initWithName:(NSString *)name url:(NSString *)url id:(int)id sprites:(NSString *)sprites abilities:(NSArray *)abilities type:(NSArray *)types
{
    if (self = [super init]) {
        _name = [name copy];
        _url = [url copy];
        _id = id;
        _abilities = [abilities copy];
        _sprites = [sprites copy];
        _types = [types copy];
        
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [NSString stringWithFormat:@"%@", dictionary[@"name"]];
    NSString *url = [NSString stringWithFormat:@"%@", dictionary[@"url"]];
    return [self initWithName:name url:url id:NULL sprites:NULL abilities:NULL type:NULL];
}

@end
