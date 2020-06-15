# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)
        Yes, there are three memory leaks which I have marked with comments in the code below.

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // Memory Leak: retains punctuationSet with an explicit "retain" and never calls release

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // Memory Leak: retains wordFrequency with "alloc" and "init" and never calls release

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
        wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; // Memory Leak: retains an unnamed NSNumber object with "alloc" and never calls release
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
        if (count) {
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
                `yesterday` is autoreleased because it is initialized with a convenience initializer.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
                `theFuture` is not autoreleased because it calls the `retain` method on the object as soon as it is initialized.
        
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
                `name` is not autoreleased because it is initialized using `alloc` and a designated `init` initializer.
	
	4. `NSDate *food = [NSDate new];`
                `food` is not autoreleased because it is initialized using `new`.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
                 `john` is not autoreleased because it is initialized using `alloc` and a designated `init` initializer.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
                `max` is autoreleased because it calls the `autorelease` method on the object as soon as it is initialized.

3. Explain when you need to use the `NSAutoreleasePool`.
An NSAutoreleasePool object holds onto objects that have been autoreleased until the NSAutoreleasePool object is drained--which typically happens after one or more event loop cylces--at which time the memory is freed. A custom `@autoreleasepool { }` block should be used in cases where we are allocating a large amount of memory within a single event loop cycle. For example, if our code contains a for-loop that iterates thousands of times and initializes (and autoreleases) a large object with each iteration of the loop, then none of the autoreleased objects will get released until sometime after the for-loop finishes. This would potentially casue the app to use up a significant amount of memory and might even cause the app to crash. To protect against this we could wrap the body of the for-loop inside  `@autoreleasepool { //body of for-loop }`, which will allow the compiler to drain the pool at the end of each and every interation of the for-loop as needed.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```
