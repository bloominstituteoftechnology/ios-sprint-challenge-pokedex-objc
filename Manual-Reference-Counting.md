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
    line 10, line 15, line 22 will add leak frequency.
    

	2. Rewrite the code so that it does not leak any memory with ARC disabled

```
swift
NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init]autorelease];

for (NSString *word in words) {
    NSNumber *count = wordFrequency[word];
    if (count) {
        wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
    } else {
        wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1]autorelease];
    }
}

printf("Word frequency: %s", wordFrequency.description.UTF8String);

```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`Date creates autorelease
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`Yes because there is an autorelease at end

3. Explain when you need to use the `NSAutoreleasePool`.
When we want to relase multiple objects in a not simple process, like for loop, we can use the relase pool to relase everything at the end of loop

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (LSIPerson *)initWithPerson:(NSString *)name;

@end

in m file:
+ (LSIPerson *)initWithPerson:(NSString *)name {
    return [[[LSIPerson alloc] initWithName:name] autorelease];
}

```
