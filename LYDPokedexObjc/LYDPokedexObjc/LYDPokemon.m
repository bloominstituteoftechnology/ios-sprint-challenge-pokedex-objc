//
//  LYDPokemon.m
//  LYDPokedexObjc
//
//  Created by Lydia Zhang on 5/22/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import "LYDPokemon.h"

@implementation LYDPokemon

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = nil;
        _imageURLStr = nil;
        _abilities = nil;
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)pokeDic{
    NSString *name = pokeDic[@"name"];
    return [self initWithName:name];
}

@end
