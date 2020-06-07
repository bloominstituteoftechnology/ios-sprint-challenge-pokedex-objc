# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; *memory leak

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; *memory leak

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; *memoryleak
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
    
    [punctuationSet release];
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    ```objc
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

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

2. Which of these objects is autoreleased?  Why?

1. `NSDate *yesterday = [NSDate date];` Yes, because it wasn't initialised with an allocation to memory.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`  No, because it retains.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` No, because it's being initialised with an allocation.
	
	4. `NSDate *food = [NSDate new];` No, because it's new.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` No, because it's being initialised with an allocation.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` Yes, because autorelease is being called after it's been intialised.

3. Explain when you need to use the `NSAutoreleasePool`. When you have numerous retained objects and you want to release them from memory, as soon as they have been used, instead of waiting for an entire operation such as a for in loop to complete, as it might crash your app.


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
