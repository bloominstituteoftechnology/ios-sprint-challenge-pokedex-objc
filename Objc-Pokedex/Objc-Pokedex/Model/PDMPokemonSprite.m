//
//  PDMPokemonSprite.m
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "PDMPokemonSprite.h"

@implementation PDMPokemonSprite

- (instancetype)initWithURL:(NSURL *)defaultURL
{
    self = [super init];
    if (self) {
        _imageURL = defaultURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *defaultURLString = dictionary[@"default_URL"];
    if (!defaultURLString) { return nil; }
    
    NSURL *defaultURL = [NSURL URLWithString:defaultURLString];
    return [self initWithURL:defaultURL];
}
@end
