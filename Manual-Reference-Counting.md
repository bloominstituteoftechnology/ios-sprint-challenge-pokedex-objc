# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
    // ^^^ Here, claiming responsibility.

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
    // ^^^ Here, allocating space in memory.

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
            // ^^^ Here, allocating space in memory.
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    ```swift
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    
    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
    [punctuationSet autorealease];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
    [wordFrequency autorelease];

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
    

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	// Autoreleased - not owned by us
    
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    // Not autoreleased - claimed responsibity with "retain"
    
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    // Not autoreleased - we stored this string object to a variable in memory using "alloc"
	
	4. `NSDate *food = [NSDate new];`
    // Not autoreleased - we stored this date object to a variable in memory using "new"
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    // Not autoreleased - we stored this person object to a variable in memory using "alloc"
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    // Autoreleased as we declared it to be

3. Explain when you need to use the `NSAutoreleasePool`.

// You can use the auto release pool to store objects that will be released when they are no longer needed, and these objects will be sent
a "release" message during the next run loop if they are no longer being retained. This frees up space in memory and prevents
memory leaks by ensuring that we are not storing objects that we no longer need.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)initWithName:(NSString *)name;

@end
```
```swift
@implementation LSIPerson: NSObject

+ (instancetype)initWithName:(NSString *)name
{
return [[[self alloc] initWithName:name] autorelease];
}

@end

