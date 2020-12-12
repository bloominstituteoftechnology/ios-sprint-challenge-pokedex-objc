//
//  Pokemon.h
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, nullable) int *identifier;
@property (nonatomic, readonly, copy, nullable) NSString *abilities;
@property (nonatomic, readonly, nullable) NSURL *spriteURL;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
