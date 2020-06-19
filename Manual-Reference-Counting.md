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
    
    There are leaks in this code. punctuationSet is manually retained and wordFrequency has a retain count of 1 because of the init. wordFrequency also retains all of the words that it inits. However, we do not release any of these at the end of the code snippet.

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    ```swift
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

    for (NSString *word in words) {
        @autoreleasepool {
            NSNumber *count = wordFrequency[word];
            if (count) {
                wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
            } else {
                wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
            }
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    
    [punctuationSet release];
    [wordFrequency release];
    ```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    
    1 and 6 are autoreleased. 1 is because Objective-C naming convention makes it so if the name doesn't begin with alloc/init, new, copy, or mutable copy, you own it so you must release it. 6 is manually marked for autorelease. The rest either begin with the naming convention or in the case of 2, it is manually retained so while it would autorelease normally, we contained it so we must release it.

3. Explain when you need to use the `NSAutoreleasePool`.

You would use a NSAutoreleasePool when you are going to use a tight for loop that would take up a lot of memory, such as looping through a large number. The issue is, because of the for loop, there is never time to clean up.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (LSIPerson *)createPersonWithName:(NSString *)name;

@end
```
