//
//  Details.h
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Details : NSObject

@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly, copy) NSString *abilities;
@property (nonatomic, readonly, copy) NSString *spriteURL;

- (instancetype)initWithIdentifier:(NSNumber *)anID
                         abilities:(NSString *)someAbilities
                         spriteURL:(NSString *)aURL;

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
