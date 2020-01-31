//
//  DPRPokemon.m
//  Pokedex
//
//  Created by Dennis Rudolph on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "DPRPokemon.h"

@implementation DPRPokemon

- (nonnull instancetype)initWithName:(nonnull NSString *)name URL:(nonnull NSURL *)url {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!name) {
        return nil;
    }
    
    if(!url) {
        return nil;
    }
    
    return [self initWithName:name URL:url];
}

@end
