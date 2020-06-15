//
//  NSURL+Secure.m
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "NSURL+Secure.h"

@implementation NSURL (Secure)

- (nullable NSURL *)URLUsingHTTPS
{
    NSURL *url = [self absoluteURL];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    
    if (!components) return nil;
    components.scheme = @"https";
    return components.URL;
}

@end
