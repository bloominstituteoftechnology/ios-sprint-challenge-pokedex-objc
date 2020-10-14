//
//  Pokemon.h
//  Pokedex
//
//  Created by Elizabeth Thomas on 10/13/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *urlString;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable) NSString *spriteURLString;
@property (nonatomic) NSMutableArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name url:(NSString *)urlString;
- (nullable instancetype)initFromDictionary:(NSDictionary *)dictionary;

- (BOOL)getDetails:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
