//
//  NYCPokemon.m
//  Pokedex
//
//  Created by Nathanael Youngren on 4/12/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

#import "NYCPokemon.h"

@implementation NYCPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *_Nullable)identifier spriteURL:(NSURL *_Nullable)spriteURL abilities:(NSArray *_Nullable)abilities detailURL:(NSURL *)detailURL {
    self = [super init];
    if (self) {
        _name = name;
        _identifier = identifier;
        _spriteURL = spriteURL;
        _abilities = abilities;
        _detailURL = detailURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *detailURLString = dictionary[@"url"];
    NSURL *detailURL = [NSURL URLWithString:detailURLString];
    return [self initWithName:name identifier:nil spriteURL:nil abilities:nil detailURL:detailURL];
}

@end
