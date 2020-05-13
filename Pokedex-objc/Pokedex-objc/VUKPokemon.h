//
//  VUKPokemon.h
//  Pokedex-objc
//
//  Created by Simon Elhoej Steinmejer on 10/12/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VUKPokemon : NSObject

- (instancetype)initWithName:(NSString *)name
                         url:(NSURL *)url;

-(nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)fillInDetailsWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSURL *url;
@property (nullable) UIImage *sprite;
@property (nonatomic, readonly, nullable) NSString *identifier;
@property (nonatomic, readonly, nullable) NSString *abilities;



@end

NS_ASSUME_NONNULL_END
