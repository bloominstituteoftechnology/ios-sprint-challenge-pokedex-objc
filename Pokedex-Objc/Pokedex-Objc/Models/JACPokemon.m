//
//  JACPokemon.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import "JACPokemon.h"

@implementation JACPokemon
- (void)fillInDetailsWithID:(NSNumber *)identifier image:(NSData *)image abilities:(NSArray<NSString *> *)abilities {
    _identifier = identifier;
    _image = image;
    _abilities = abilities;
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier image:(NSData *)image abilities:(NSArray<NSString *> *)abilities {
    if (self = [super init]) {
        _name = name;
        _identifier = identifier;
        _image = image;
        _abilities = abilities;
    }
    return self;
}
@end
