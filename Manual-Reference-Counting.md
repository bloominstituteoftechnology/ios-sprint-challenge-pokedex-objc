# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
    Line 10 is a leak, there is a retain but no release, remove retain. (This is an autorelease object)
    
	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];


    Leak on line 18, alloc init but with no release or autorelease
	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
        Leak on line 26, alloc init increases the retain count but there is no release or autorelease.
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

    ```swift
        NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    
        NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];
    
        NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
        NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
    
        NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
    
        for (NSString *word in words) {
            NSNumber *count = wordFrequency[word];
            if (count) {
                wordFrequency[word] = @(count.integerValue + 1);
            } else {
                wordFrequency[word] = @(1);
            }
        }
    
        printf("Word frequency: %s", wordFrequency.description.UTF8String);
        // Clean up 
        [wordFrequency release]; // You can also make wordFrequency an autoreleased object.
        ```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
        Yes, not alloc/init
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    No, there is retain at the end, must be released.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    No, there is alloc/init
	
	4. `NSDate *food = [NSDate new];`
    No, it uses new
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    No, this uses alloc/init
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    Yes, this uses autorelease

3. Explain when you need to use the `NSAutoreleasePool`.

This is a way to make autorelease work, so that memory can be cleaned up in the future (end of scope)
You use this when you are in a tight for loop that doesn't have enough time for the autorelease pool to run. You wrap statments in it so that you can release memory when processing multiple data files of a large size in a loop, if not you can potentially raise the memory footprint (since autorelease doesn't have a chance to run) and it can cause the app to crash.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```

LSIPerson.h
```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

// Solution

+ (instancetype)personWithName:(NSString *)name;

@end
```

LSIPerson.m
```swift
#import "LSIPerson.h"
@implementation LSIPerson

- (instancetype)initWithName:(NSString *)name {
    if(self = [super init]) {
        _name = name;
    }
    return self;
}

// Solution
+ (instancetype)personWithName:(NSString *)name {
    return [[[LSIPerson alloc] initWithName:name] autorelease];
}

@end
```
