//
//  SDJPokemon.m
//  ObjCPokedex
//
//  Created by Shawn James on 6/19/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

#import "SDJPokemon.h"

@implementation SDJPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    
    if (self = [super init]) {
        _name = [name copy];
        _url = [url copy];
    }
    return self;
}

@end
