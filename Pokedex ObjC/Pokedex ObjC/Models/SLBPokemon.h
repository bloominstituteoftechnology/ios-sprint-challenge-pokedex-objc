//
//  SLBPokemon.h
//  Pokedex ObjC
//
//  Created by Scott Bennett on 11/30/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLBPokemon : NSObject

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *)identier;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *identifier;


@end

NS_ASSUME_NONNULL_END
