//
//  DMOPokemon.h
//  Week15SprintChallenge
//
//  Created by morse on 1/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMOPokemon : NSObject

@property (nonatomic, copy, nonnull) NSString *name; //  "name": "bulbasaur"
@property (nonatomic, nullable) NSURL *infoURL;
@property (nonatomic) int idenitifier; // "id": 1
@property (nonatomic, copy, nullable) NSString *abilities; // see below
@property (nonatomic, copy, nullable) NSURL *sprite; // see below

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                             infoURL:(nullable NSURL *)infoURL
                          identifier:(int)identifier
                           abilities:(nullable NSString *)abilities
                              sprite:(nullable NSURL *)sprite;
- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
