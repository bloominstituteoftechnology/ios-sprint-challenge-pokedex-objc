//
//  TSAPokemon.m
//  Pokedex
//
//  Created by Alex Thompson on 6/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "TSAPokemon.h"

@implementation TSAPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)url
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = [url copy];
    }
    
    return self;
}

@end
