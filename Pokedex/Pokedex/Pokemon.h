//
//  Pokemon.h
//  Pokedex
//
//  Created by Bobby Keffury on 2/23/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface Pokemon : NSObject

//MARK: - Initialization

-(instancetype)initDictionary:(nullable NSDictionary *)dictionary;
-(instancetype)initWithName:(NSString *)name url:(NSString *)url id:(nullable NSString *)id abilities:(nullable NSMutableArray<NSString *> *)abilities sprite:(nullable NSString *)sprite;

//MARK: - Properties

@property (nonnull) NSString *name;
@property (nonnull) NSString *url;
@property (nullable) NSString *id;
@property (nullable) NSString *sprite;
@property (nullable) NSMutableArray<NSString *> *abilities;

@end

NS_ASSUME_NONNULL_END
