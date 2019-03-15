//
//  JMKPokemon.h
//  PokeDexObjC
//
//  Created by TuneUp Shop  on 3/15/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface JMKPokemon : NSObject

@property (readonly, copy) NSURL *url;
@property (readonly, copy) NSString *name;
@property (readonly, copy) NSURL *spriteURL;
@property (readonly, copy) NSString *identifier;
@property (readonly, copy) NSString *abilitiesString;
@property (readonly, copy) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name URL:(NSURL *)url;
- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *>  *)dictionary;

- (void)fillInDetailsWithDictionary:(NSDictionary *)dictionary;



@end

//NS_ASSUME_NONNULL_END
