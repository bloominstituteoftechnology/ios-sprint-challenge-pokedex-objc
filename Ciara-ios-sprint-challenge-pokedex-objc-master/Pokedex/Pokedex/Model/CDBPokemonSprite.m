//
//  CDBPokemonSprite.m
//  Pokedex
//
//  Created by Ciara Beitel on 3/27/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import "CDBPokemonSprite.h"

@implementation CDBPokemonSprite

- (instancetype)initWithImageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *imageURLString = dictionary[@"front_shiny"];
    if (!imageURLString) { return nil; }
    
    NSURL *frontShinyURL = [NSURL URLWithString:imageURLString];
    return [self initWithImageURL:frontShinyURL];
}

@end
