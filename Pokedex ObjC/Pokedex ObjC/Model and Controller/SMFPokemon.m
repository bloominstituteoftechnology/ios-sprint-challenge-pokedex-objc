//
//  SMFPokemon.m
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

#import "SMFPokemon.h"
#import <UIKit/UIKit.h>

@interface SMFPokemon ()

@property (readwrite, nullable) NSURL *imageURL;
@property (readwrite, nullable) NSString *identifier;
@property (readwrite, nullable) NSString *abilities;

@end

@implementation SMFPokemon

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

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *identifier = dictionary[@"id"];
    
    NSArray<NSDictionary *> *abilitiesArray = dictionary[@"abilities"];
    NSString *abilitiesString = @"";
    for (NSDictionary *abilityDictionary in abilitiesArray) {
        NSDictionary<NSString *, NSString *> *abilitySubDictionary = abilityDictionary[@"ability"];
        NSString *abilityName = abilitySubDictionary[@"name"];
        abilitiesString = [NSString stringWithFormat:@"%@, %@", abilitiesString, abilityName];
    }
    if (![abilitiesString isEqualToString:@""]) {
        abilitiesString = [abilitiesString substringFromIndex:2];
    }
    
    NSDictionary<NSString *, id> *sprites = dictionary[@"sprites"];
    NSString *urlString = sprites[@"front_default"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    self.identifier = identifier.stringValue;
    self.abilities = abilitiesString;
    self.imageURL = url;
}

@end
