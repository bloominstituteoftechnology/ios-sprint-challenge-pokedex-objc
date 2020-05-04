//
//  Pokemon.h
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, copy, nullable) NSMutableArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSMutableArray<NSString *> *)abilities;

- (instancetype)initWithName:(NSString *)name url:(NSString *)url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
