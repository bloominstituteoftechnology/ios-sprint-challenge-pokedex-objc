# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)
Yes, there are memory leaks.
	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; -memoryleak*

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; -memoryleak*

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; -memoryleak*
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

2. Rewrite the code so that it does not leak any memory with ARC disabled

    NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init] autorelease; 

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[NSNumber alloc] initWithInteger:1] autorelease; 
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);

2. Which of these objects is autoreleased? Why?

	1. `NSDate *yesterday = [NSDate date];`
           Yes, it didnt init with alloc.
           
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
            No, it retains.
           
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	     No, it initializes with alloc?
         
	4. `NSDate *food = [NSDate new];`
            No, its new.
            
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
           No, initializes with alloc.
           
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
            Yes, it autoleases at the end.
    
3. Explain when you need to use the `NSAutoreleasePool`.
   When you have lots of objects and you want to dealloc all of them. - its when you want to release memory before an entire loop is done.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
 
 (LSIPerson *)person {
     return [[[LSIPerson alloc] init ] autorelease];
}

@end
