# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // not released

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // not released

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; // not released
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
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
    wordFrequency[word] = [[NSNumber alloc] initWithInteger:1] autorelease];
    }
    }
    
    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    [puncuationSet release];
    [cleanQuote release];
    [wordFrequency release];
    
    ```
        

2. Which of these objects is autoreleased?  Why?

1. `NSDate *yesterday = [NSDate date];` autoreleased.. no alloc init 
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`  not autoreleased 
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`  not autoreleased has alloc/init
	
	4. `NSDate *food = [NSDate new];` not autoreleased...has new
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` not autoreleased has alloc/init
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` not autoreleased has alloc/init

3. Explain when you need to use the `NSAutoreleasePool`.
whenever you have autoreleased object you want released. in your main method. in "tight loops" that keep generating new objects


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)personWithName:(NSString *)name;

@end
```

```swift
@implementation LSIPerson: NSObject

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;

}

+ (instancetype)personWithName:(NSString *)name {
    return [[self initWithName:name] autorelease];
}

@end
```
