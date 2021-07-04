# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)
YES. There are memory leaks
	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; ********HERE*****************

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "]; //no

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init] autorelease; ********HERE*****************

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

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain] autorelease]; ********HERE

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "]; //no

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init] autorelease; ********HERE

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    

2. Which of these objects is autoreleased?  Why?

1. `NSDate *yesterday = [NSDate date];` ---- Autoreleased: we are not responsible for memory here
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` No, Retained is used here.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` No, alloc is used here.
	
	4. `NSDate *food = [NSDate new];` No, new is used here.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` No, alloc is used here we are responsible.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` Autorelease--- it states it.

3. Explain when you need to use the `NSAutoreleasePool`.
This allows autorelease to happen inside loops with large data.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

@implementation
- (instancetype)initWithName:(NSString *)name
{
    
    if (self = [super init]) {
       _name = name;
    }
    return [[self copy] autorelease];
}
@end

```
