//
//  VUKPokemon.m
//  Pokedex-objc
//
//  Created by Simon Elhoej Steinmejer on 10/12/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

#import "VUKPokemon.h"
#import <UIKit/UIKit.h>

@interface VUKPokemon()

@property NSURL *imageURL;
@property (readwrite, nullable) NSString *identifier;
@property (readwrite, nullable) NSString *abilities;


@end



@implementation VUKPokemon


- (instancetype)initWithName:(NSString *)name url:(NSURL *)url
{
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}




- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    
    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [self initWithName:name url:url];
}


- (void)fillInDetailsWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    
    NSDictionary<NSString *, id> *sprites = dictionary[@"sprites"];
    NSString *urlString = sprites[@"front_default"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSNumber *identifier = dictionary[@"id"];
    NSArray<NSDictionary *> *abilitiesArray = dictionary[@"abilities"];
    NSString *allAbilities = @"";
    
    for (NSDictionary *abilities in abilitiesArray) {
        NSDictionary<NSString *, NSString *> *abilitiesSubDictionary = abilities[@"ability"];
        NSString *ability = abilitiesSubDictionary[@"name"];
        allAbilities = [NSString stringWithFormat:@"%@ %@", allAbilities, ability];
    }
    
    
    self.identifier = [identifier stringValue];
    self.abilities = allAbilities;
    self.imageURL = url;
    
    
    
}


@end
