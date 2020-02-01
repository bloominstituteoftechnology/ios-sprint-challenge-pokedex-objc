//
//  LSIPokemon.m
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        _name = dictionary[@"name"];
        NSURL *urlFromString = dictionary[@"url"];
        _url = urlFromString;
    }
    return self;
}

@end
