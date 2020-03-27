//
//  CDBPokemon.m
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import "CDBPokemon.h"

@implementation CDBPokemon

- (instancetype) initWithName:(NSString *)name withURL:(NSString *)url {
    if (self = [super init]) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];
    
    return [self initWithName:name withURL:url];
}

@end
