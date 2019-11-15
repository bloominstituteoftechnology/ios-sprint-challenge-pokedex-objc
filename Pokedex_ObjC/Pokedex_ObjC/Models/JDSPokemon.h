//
//  JDSPokemon.h
//  Pokedex_ObjC
//
//  Created by Lambda_School_Loaner_214 on 11/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDSPokemon : NSObject
@property (nonatomic, copy, readwrite) NSString                          *name;
@property (nonatomic, copy, readwrite, nullable) NSURL                   *spriteURL;
@property (nonatomic, copy, readwrite, nullable) NSNumber                *idNumber;
@property (nonatomic, copy, readwrite, nullable) NSArray <NSString *>    *abilities;

-(instancetype)initWithName:(NSString *)name sprite:(NSURL *)spriteURL idNumber:(NSNumber *)idNumber abilities:(NSArray *)abilities;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSComparisonResult) compare:(JDSPokemon*) pokemon;

@end

NS_ASSUME_NONNULL_END
