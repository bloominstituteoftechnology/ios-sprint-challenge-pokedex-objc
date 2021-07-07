//
//  NKTPokemon.m
//  Pokedex
//
//  Created by Nikita Thomas on 2/1/19.
//  Copyright © 2019 Nikita Thomas. All rights reserved.
//

#import "NKTPokemon.h"

@implementation NKTPokemon

-(instancetype)initWithName:(NSString *)name detailURL:(NSString *)detailURL
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _detailURL = [detailURL copy];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name pokemonID:(NSInteger)pokemonID detailURL:(NSString *)detailURL imageURL:(NSString *)imageURL abilities:(NSArray *)abilities
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _pokemonID = pokemonID;
        _detailURL = [detailURL copy];
        _imageURL = [imageURL copy];
        _abilities = [abilities copy];
    }
    return self;
}


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *detailURL = dictionary[@"url"];
    
    return [self initWithName:name detailURL:detailURL];
}

@end
