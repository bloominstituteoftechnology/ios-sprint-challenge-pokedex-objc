# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];


	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
      // retain removed
	NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

     //autorelease added
	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
              //autorelease added
			wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    
    1 and 6 are auto released and are marked as such. 2, 3, 4, 5 are allocated with retain, new, and alloc without specififying autorelease.

3. Explain when you need to use the `NSAutoreleasePool`.

NSAutoReleasePool is used to remove objects created in loops before each successive iteration.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithNameAutorelease:(NSString *)name;

@implementation LSIPerson

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        _name = name;
    }
    
    return self;
}

- (instancetype)initWithNameAutoRelease:(NSString *)name {
    return [[[LSIPerson alloc] initWithName:name] autorelease];
}

@end
```
