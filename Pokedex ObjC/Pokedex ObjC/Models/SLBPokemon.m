//
//  SLBPokemon.m
//  Pokedex ObjC
//
//  Created by Scott Bennett on 11/30/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

#import "SLBPokemon.h"

@implementation SLBPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *)identifier;
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
{
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"url"];
    if (!name || !identifier) {
        return nil;
    }
    
    return [self initWithName:name identifier:identifier];
    
}

@end
