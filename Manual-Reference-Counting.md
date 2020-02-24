# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	The leaks happened on 
	- punctuationSet doesn't need "retain"
	- [[NSNumber alloc] initWithInteger:1] needs an "autorelease"
	- wordFrequency needs to be released at the end

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

	2. Rewrite the code so that it does not leak any memory with ARC disabled

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count != nil) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	[wordFrequency release];
	```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
		
		It's autoreleased. 	`yesterday` doesn't own it. It's autoreleased in the class function.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`

		No, it's not because there is a `retain`.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`

		No, it's not because there is `alloc initWithString`. It's owned.
	
	4. `NSDate *food = [NSDate new];`

		No, it's not because there is `new`.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`

		No, it's not because there is `alloc initWithName`. It's owned.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`

		Yes, it's autorelease because there is `autorelease`.

3. Explain when you need to use the `NSAutoreleasePool`.

	NSAutoreleasePool simply contains other objects, and when deallocated, sends a release message to each of those objects. An object can be put into the same pool several times, and receives a release message for each time it was put into the pool.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```

```swift
+ (instancetype)personWithName:(NSString *)name
{
    return [[[self alloc]initWithName:name] autorelease];
}
```
