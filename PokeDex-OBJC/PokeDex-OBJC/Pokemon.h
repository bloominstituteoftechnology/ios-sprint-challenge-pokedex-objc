//
//  Pokemon.h
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSNumber *identifier;
@property (nonatomic, copy) NSArray<NSString *> *abilities;
@property (nonatomic, copy) NSURL *image;
@property (nonatomic, copy) NSURL *url;

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                   abilities:(NSArray<NSString *> *)abilities
                       image:(NSURL *)image
                         url:(NSURL *)url;

- (instancetype)initWithDictioanryForList:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
