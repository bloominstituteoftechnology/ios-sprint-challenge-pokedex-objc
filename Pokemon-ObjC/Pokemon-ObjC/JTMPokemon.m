//
//  JTMPokemon.m
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/12/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import "JTMPokemon.h"

@implementation JTMPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier sprite:(NSData *)sprite abilities:(NSArray<NSString *> *)abilities
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _sprite = [sprite copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    
    return [self initWithName:name identifier:<#(nonnull NSString *)#> sprite:<#(nonnull NSData *)#> abilities:<#(nonnull NSArray<NSString *> *)#>]
}

@end
