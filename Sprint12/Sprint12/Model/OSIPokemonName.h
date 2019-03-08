//
//  OSIPokemonName.h
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSIPokemonName : NSObject
@property (nonatomic, readonly) NSArray<NSString *> *names;
@property (nonatomic, copy, readonly) NSArray<NSString *> *url;

- (instancetype)initWithJSON:(id)json;
@end

NS_ASSUME_NONNULL_END
