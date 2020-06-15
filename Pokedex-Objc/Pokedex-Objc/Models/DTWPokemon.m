//
//  DTWPokemon.m
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "DTWPokemon.h"
#import "DTWPokemonDetail.h"
#import "NSURL+Secure.h"

@implementation DTWPokemon

- (instancetype)initWithName:(NSString *)name URL:(NSURL *)detailsURL
{
    if (self = [super init]) {
        _name = name.copy;
        _detailsURL = detailsURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [[dictionary objectForKey:@"name"] capitalizedString];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    NSString *URLString = [dictionary objectForKey:@"url"];
    if (![URLString isKindOfClass:[NSString class]]) return nil;
    
    NSURL *URL = [NSURL URLWithString:URLString].URLUsingHTTPS;
    
    return [self initWithName:name URL:URL];
}

@end
