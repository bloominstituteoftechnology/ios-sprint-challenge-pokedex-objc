# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; ----> // The memory leak is being retained and never released.

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; ----> // The memory leak is occrring here as well as the memory is allocated and initialized with an integer but failed to be released. 
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    ```swift
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [ NSCharacterSet punctuationCharacterSet]; // ----->  Removed retained in order to release memory. 

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
        wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];  //  -----> implement autorelease. 

        }
    }
    [punctuationSet release];
    [wordFrequency release];

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    ```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` 
    
            This object is being autorelased becasue the object is not being allocated to memory.  
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    
            This is being retained and not autoreleased so we are responsible for releasing. 
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    
            This is allocating the memory and initializing it but is not being autoreleased, we are responsible for releasing it. 
	
	4. `NSDate *food = [NSDate new];`
    
            This is using a new phrase in the code and is not autoreleasing. 
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
        
            This is allocating the memory and initializing it but is not being autoreleased, we are responsible for releasing it.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` 
        
            This is being autorealeased at the end of the code. 

3. Explain when you need to use the `NSAutoreleasePool`.

        You will most commanlly use NSAutorealeasePool when looping through a big object where it than can be held onto until you call drain() where it will than deallocate from the pool once its full. 

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

@implementation LSIPerson

+ (LSIPerson *) name

{
return [[[LSIPerson alloc] init] autoreleased];
}

@end
```
