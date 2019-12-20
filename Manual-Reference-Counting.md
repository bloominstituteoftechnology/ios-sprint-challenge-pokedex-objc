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
    - Yes. Leaks with *quote, *punctuationSet, *cleanQuote, *words


	2. Rewrite the code so that it does not leak any memory with ARC disabled
```swift

NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

for (NSString *word in words) {
    NSNumber *count = wordFrequency[word];
    if (count == nil) {
        wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
    } else {
        wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
    }
}

printf("Word frequency: %s", wordFrequency.description.UTF8String);

```
    
    

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    - Yes. Autoreleased Object.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    - No. Object is retained.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    - No. Not an autoreleased object.
	
	4. `NSDate *food = [NSDate new];`
    - Yes. Autoreleased Object.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    - No. Not released.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    - Yes. Released at the end.

3. Explain when you need to use the `NSAutoreleasePool`.
- You use this when you have big data set like multiple images being pulled down from a server or looped over.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift

@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

Person *person = [[[Person alloc] initWithName: name] autorelease];

@end
```
