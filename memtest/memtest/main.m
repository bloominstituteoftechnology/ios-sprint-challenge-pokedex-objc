//
//  main.m
//  memtest
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    //@autoreleasepool {
        // insert code here...
        NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

        NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

        NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
        // MARK: punctuationSet not used after line 18
        [punctuationSet release];
        
        NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

        NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

        for (NSString *word in words) {
            NSNumber *count = wordFrequency[word];
            if (count) { // MARK: Static analyzer complains about ptr compared to BOOL
                wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
            } else {
                wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease]; // MARK: Needs to be autoreleased
            }
        }

        printf("Word frequency: %s", wordFrequency.description.UTF8String);
        
        // MARK: line 24 called with alloc init, must release
        [wordFrequency release];
    //}
    return 0;
}
