# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // leak is never released

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // leak won't be autoreleased

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; // leak is never released
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet]; // FIXED

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [][[NSMutableDictionary alloc] init] autorelease]; // FIXED

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber initWithInteger:1]; // FIXED
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```
	

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` // Yes object is not allocating memory
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` // NO because of retain
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` // No because memory is being manually allocated
	
	4. `NSDate *food = [NSDate new];` // No 'new' retains object
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` // No because memory is being manually allocated
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` // Yes, object is being set to autorelease

3. Explain when you need to use the `NSAutoreleasePool`.

// NSAutoreleasePool needs to be used when looping through a large set of data because each property is being initalized with it's own spot in memory.
// NSAutoreleasePool will manage the loop and release objects when needed.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)initPersonWithName:(NSString *)aName;
@end

@implementation LSIPerson

+ (instancetype)initPersonWithName:(NSString *)aName
{
	LSIPerson *person = [[self alloc]initPersonWithName:name];
	return [person autorelease];
}


```
