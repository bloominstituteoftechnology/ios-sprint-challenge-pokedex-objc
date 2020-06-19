//
//  LSIPokemon.m
//  Pokedex
//
//  Created by Bhawnish Kumar on 6/19/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

- (instancetype)initWithName:(NSString *)name detailURL:(NSString *)detailURL {
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _detailURL = [detailURL copy];
    }
    return self;

}

@end
