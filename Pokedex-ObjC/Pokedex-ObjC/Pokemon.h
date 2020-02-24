//
//  Pokemon.h
//  Pokedex-ObjC
//
//  Created by Fabiola S on 2/21/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pokemon : NSObject

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic) int id;
@property (nonatomic, copy, nullable) NSArray *abilities;
@property (nonatomic, copy, nullable) NSString *url;
@property (nonatomic, copy, nullable) NSString *sprites;

- (nonnull instancetype)initWithName:(nullable NSString *)name
                                 url:(nullable NSString *)url
                                  id:(int)id
                             sprites:(nullable NSString *)sprites
                           abilities:(nullable NSArray *)abilities;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;


@end

