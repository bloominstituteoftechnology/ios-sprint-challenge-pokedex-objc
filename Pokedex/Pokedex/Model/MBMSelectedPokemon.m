//
//  MBMSelectedPokemon.m
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMSelectedPokemon.h"

@implementation MBMSelectedPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(int)identifier
                     ability:(NSArray *)ability
                  largeImage:(NSURL *)largeImage {
    
    self = [super init];
    if (self) {
        _name = name;
        _identifier = [NSNumber numberWithInt:identifier];
        _ability = ability;
        _largeImage = largeImage;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    return self;
}

@end
