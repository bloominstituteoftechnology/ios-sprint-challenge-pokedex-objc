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
    
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *detailURL = dictionary[@"url"];
    
    return [self initWithName:name detailURL:detailURL];
}

@end
