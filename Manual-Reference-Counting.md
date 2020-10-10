# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // Leak here as it is retained, but never released.

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // Leak here as it is allocated and initialzed, but never released.

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; // Leak here as it is allocated and initialzed with an integer, but never released.
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    
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
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease]; 
        }
    }
    
    [punctuationSet release];

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    
    [wordFrequency release]
    ```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    
            autoreleased as we are not responsible for it since we did not allocate, initialize, retain, or use the keyword new.
            
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    
            This is not autoreleased as we are retaining it which makes it our responsibility to release it.

	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    
            This is not autoreleased as we are allocating the memory and initializing it. So we are responsible for releasing it.
	
	4. `NSDate *food = [NSDate new];`
    
            This is not autoreleased as we are using the new phrase in the code.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    
            This is not autoreleased as we are allocating the memory and initializing it. So we are responsible for releasing it.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    
            autoreleased since autorelease is used at the end of the code.
            
3. Explain when you need to use the `NSAutoreleasePool`.

    You need to use NSAutoreleasePool when you are turning off ARC for your project. This will be done in the main.m file after you have turned ARC off.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

@implementation LSIPerson

+ (LSIPerson *) name
{
return [[[LSIPerson alloc] init] autorelease];
}

@end
```
