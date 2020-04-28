# Manual Reference Counting

Answer the following questions inline with this document.

1. 

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet]];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` 
        - No
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` 
        - No, 'retain' called
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
        - No, 'alloc' but no autorelease
	
	4. `NSDate *food = [NSDate new];`
        - No, 'new' is clalled
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
        - No, 'alloc' but no 'autorelease'
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
        - Yes 'autorelease is called'

3. Explain when you need to use the `NSAutoreleasePool`.
- NSAutoreleasePool is helpful in cases where you retain many objects and want them to be released after the usement. (For in Loop)


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

- (LSIPerson *)personWithName:(NSString *)name {
return [[[LSIPerson alloc] initWithName:name] autorelease];
}

@end
```
