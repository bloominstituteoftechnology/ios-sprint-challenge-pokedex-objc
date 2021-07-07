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

@property (readonly, copy, nullable) NSURL *url;
@property (readonly, copy, nullable) NSString *name;
@property (readonly, copy, nullable) NSURL *spriteURL;
@property (readonly, copy, nullable) NSString *identifier;
@property (readonly, copy, nullable) NSString *abilitiesString;
@property (readonly, copy, nullable) NSArray<NSString *> *abilities;

- (instancetype _Nonnull )initWithName:(NSString *_Nonnull)name URL:(NSURL *_Nonnull)url;
- (instancetype _Nullable )initWithDictionary:(NSDictionary<NSString *, NSString *>  *_Nullable)dictionary;

- (void)fillInDetailsWithDictionary:(NSDictionary *_Nonnull)dictionary;



@end

//NS_ASSUME_NONNULL_END
