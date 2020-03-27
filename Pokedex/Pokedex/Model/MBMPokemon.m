//
//  MBMPokemon.m
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMPokemon.h"

@implementation MBMPokemon

- (instancetype)initWithName:(NSString *)name
                         url:(NSURL *)url {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    self = [self initWithName:name
                          url:url];
 
    return self;
}

@end
