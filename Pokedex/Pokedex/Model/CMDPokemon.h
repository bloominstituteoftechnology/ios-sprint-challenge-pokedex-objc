//
//  CMDPokemon.h
//  Pokedex
//
//  Created by Chris Dobek on 6/19/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMDPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *infoURL;
@property (nonatomic) int idenitifier;
@property (nonatomic, copy) NSString *abilities;
@property (nonatomic, copy) NSURL *sprite;

- (instancetype)initWithName:(nonnull NSString *)name
                             infoURL:(nullable NSURL *)infoURL
                          identifier:(int)identifier
                           abilities:(nullable NSString *)abilities
                              sprite:(nullable NSURL *)sprite;

- (instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
