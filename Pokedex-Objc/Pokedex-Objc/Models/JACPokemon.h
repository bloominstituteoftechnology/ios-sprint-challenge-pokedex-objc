//
//  JACPokemon.h
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JACPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *identifier;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nullable, nonatomic, copy) NSArray<NSString *> *abilities;

- (void)fillInDetailsWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithName:(NSString *)name url:(NSString *)url;
- (instancetype)initWithName:(NSString *)name url:(NSString *)url identifier:(NSNumber *)identifier abilities:(NSArray<NSString *> *)abilities;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end

NS_ASSUME_NONNULL_END
