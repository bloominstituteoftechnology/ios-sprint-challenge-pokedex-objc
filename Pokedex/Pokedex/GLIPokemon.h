//
//  GLIPokemon.h
//  Pokedex
//
//  Created by Julian A. Fordyce on 4/12/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GLIPokemon : NSObject

- (instancetype)initWithName:(NSString *)name  id:(NSInteger)identifier spritesURL:(NSString *)spritesURL abilities:(NSString *)abilities;

// - (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly) NSString *spritesURL;
@property (nonatomic, copy, readonly) NSString *abilities;

@end

NS_ASSUME_NONNULL_END
