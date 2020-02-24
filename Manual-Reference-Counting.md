# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

                                                                            Leak vvvvv
	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

                                                                                               Leak vvvvv
	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
                                        Leak vvvvv
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
                                                                  Leak vvvvv
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];
    
    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
    
    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];
    
    for (NSString *word in words) {
        NSNumber *count = [[wordFrequency[word] retain] autorelease];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
        }
    }
    
    print("Word frequency: %s", wordFrequency.description.UTF8String);

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    
        Yes - We do not own this object and thus we do not need to release it. It does not contain (new, alloc, init, retain, copy, mutableCopy etc.)
    
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    
        Yes - Autorelease is called.

3. Explain when you need to use the `NSAutoreleasePool`.

Usually used when conduction manual reference counting, you will use NSAutoreleasePool to keep a stack of the objects you intend to release. You definitely would not want to use this in the case of automatic reference counting. In short, when you want to manually control when your objects are released & you are working with objective - c, use NSAutoreleasePool.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```

@implementation

(LSIPerson *)LSIPerson {

return [[[LSIPerson alloc] init] autorelease];

}

@end


