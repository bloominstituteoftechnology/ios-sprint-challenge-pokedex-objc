//
//  FAFPokemon.m
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import "FAFPokemon.h"

@implementation FAFPokemon
    
-(instancetype)initWithName:(NSString *)name detailURL:(NSString *)detailURL
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _detailURL = [detailURL copy];
    }
    return self;
}
    
- (instancetype)initWithName:(NSString *)name pokemonID:(NSInteger)pokemonID detailURL:(NSString *)detailURL weight:(NSInteger)weight baseXP:(NSInteger)baseXP imageURL:(NSString *)imageURL abilities:(NSArray *)abilities types:(NSArray *)types
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _pokemonID = pokemonID;
        _detailURL = [detailURL copy];
        _weight = weight;
        _baseXP = baseXP;
        _imageURL = [imageURL copy];
        _abilities = [abilities copy];
        _types = [types copy];
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
