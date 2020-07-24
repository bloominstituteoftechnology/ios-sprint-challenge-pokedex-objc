//
//  DBEPokemon.h
//  PokedexSprint
//
//  Created by Dahna on 7/24/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface DBEPokemon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, nullable) NSURL *spriteURL;
@property (nonatomic, readonly) NSURL *detailURL;
@property (nonatomic, nullable) NSNumber *id;
@property (nonatomic, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, nullable) UIImage *sprite;

- (instancetype)initWithName:(NSString *)name detailURL:(NSURL *_Nonnull)detailURL;

- (instancetype)fetchDetails:(NSDictionary *)dictionary;

@end


NS_ASSUME_NONNULL_END
