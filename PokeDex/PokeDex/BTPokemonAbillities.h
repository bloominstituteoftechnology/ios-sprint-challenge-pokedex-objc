//
//  BTPokemonAbillities.h
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTPokemonAbillities : NSObject

@property (nonatomic, readonly, copy) NSString *name;

-(instancetype)initWithName:(NSString *)name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
