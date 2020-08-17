//
//  KRHPokemonAbilities.m
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "KRHPokemonAbilities.h"

@implementation KRHPokemonAbilities

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

// FIXME: need to loop through the multiple dictionaries inorder to get all the abilities.

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    
    self = [self initWithName:name];
    return self;
}



@end
