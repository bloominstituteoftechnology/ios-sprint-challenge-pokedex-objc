//
//  YZIPokedex.m
//  Pokedex
//
//  Created by Yvette Zhukovsky on 2/1/19.
//  Copyright © 2019 Yvette Zhukovsky. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YZIPokedex.h"

@interface YZIPokedex ()

@property (readwrite, nullable) NSString *identifier;
@property (readwrite, nullable) NSURL *imagesURL;
@property (readwrite, nullable) NSString *abilities;


@end


@implementation YZIPokedex

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
    NSString *urlStrings = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlStrings];
    
    return [self initWithName:name url:url];
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *identifier = dictionary[@"id"];
    
    NSArray<NSDictionary *> *abilitiesArray = dictionary[@"abilities"];
    NSString *abilitiesString = @"";
    for (NSDictionary *abilitiesDictionary in abilitiesArray) {
        NSDictionary<NSString *, NSString *> *abilitiesValueDictionary = abilitiesDictionary[@"ability"];
        NSString *abilitiesName = abilitiesValueDictionary[@"name"];
        abilitiesString = [NSString stringWithFormat:@"%@, %@", abilitiesString, abilitiesName];
    }
    if (![abilitiesString isEqualToString:@""]) {
        abilitiesString = [abilitiesString substringFromIndex:2];
    }
    
    NSDictionary<NSString *, id> *sprites = dictionary[@"sprites"];
    NSString *urlString = sprites[@"front_default"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    self.identifier = identifier.stringValue;
    self.abilities = abilitiesString;
    self.imagesURL = url;
}

@end
