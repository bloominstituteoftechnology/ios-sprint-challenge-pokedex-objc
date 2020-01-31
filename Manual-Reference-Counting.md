# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```
	
Yes, punctuationSet is retained and never released. wordFrequency is initialized with alloc and never released. The number in the else statement is initialized using alloc and never release.

	2. Rewrite the code so that it does not leak any memory with ARC disabled
	
	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if ([count boolValue]) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [NSNumber numberWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	
	[wordFrequency release]
	```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	Autoreleased because it doesn't use any of the owning keywords
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	Not autoreleased because it calls retain
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	Not autoreleased because it uses the owning initializer "alloc init"
	
	4. `NSDate *food = [NSDate new];`
	Not autoreleased because it uses the owning initializer "new"
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	Not autoreleased because it uses the owning initializer "alloc init"
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
	Autoreleased because it calls autorelease

3. Explain when you need to use the `NSAutoreleasePool`.
When you have a potentially large array of large objects.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

}

@end

#import "LSIPerson.h"

@implementation LSIPerson

- (instancetype)initWithName:(NSString *)name {
	self = [super init];
	if (self) {
        _name = [name copy];
	}
	return self;
}

+ (instancetype)personWithName:(NSString *)name {
    return [[[Person alloc] initWithName:name] autorelease];
```
