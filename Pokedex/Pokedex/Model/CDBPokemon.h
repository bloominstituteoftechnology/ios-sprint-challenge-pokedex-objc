//
//  CDBPokemon.h
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBPokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *url;
@property (nonatomic, readonly, copy) NSNumber *identifier;
@property (nonatomic, readonly, copy) NSDictionary *sprites;
@property (nonatomic, readonly, copy) NSArray *abilities;

- (instancetype) initWithName:(NSString *)name withURL:(NSString *)url;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
