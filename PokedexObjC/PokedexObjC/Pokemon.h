//
//  Pokemon.h
//  PokedexObjC
//
//  Created by Carolyn Lea on 10/12/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly, nullable) NSArray *abilities;
@property (nonatomic, readonly, nullable) NSURL *spriteURL;
@property (nullable) UIImage *image;

-(instancetype)initWithName: (NSString *)name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(void)fillWithDictionary:(NSDictionary *)fillDictionary;

@end

NS_ASSUME_NONNULL_END
