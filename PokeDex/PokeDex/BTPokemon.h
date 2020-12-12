//
//  BTPokemon.h
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTPokemon : NSObject

@property (nonatomic,readonly, copy) NSString *name;
@property NSNumber *identifier;
@property NSURL *image;
@property NSArray<NSString *> *abilitiesArray;

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSNumber *)identifier
                     sprite:(NSURL *)sprite
             abilitiesArray:(NSArray<NSString *> *)abilitiesArray;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
