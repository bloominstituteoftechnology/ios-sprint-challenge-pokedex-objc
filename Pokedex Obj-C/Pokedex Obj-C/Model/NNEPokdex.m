//
//  NNEPokdex.m
//  Pokedex Obj-C
//
//  Created by Nonye on 7/24/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import "NNEPokdex.h"

@implementation NNEPokdex

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = [url copy];
    }
    return self;
}

@end
