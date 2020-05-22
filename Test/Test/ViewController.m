//
//  ViewController.m
//  Test
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // this is retained but never released

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // this is retained but never released

for (NSString *word in words) { // we are allocating in a tight loop here
    @autoreleasepool {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
        }
    }
}

printf("Word frequency: %s", wordFrequency.description.UTF8String);

[punctuationSet release];
[wordFrequency release];
}


@end
