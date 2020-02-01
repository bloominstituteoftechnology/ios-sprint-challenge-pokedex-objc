# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

            //RETAIN NEVER GETS RELEASED
	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
        //NOT AUTORELEASED
	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
                    //NOT AUTORELEASED
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
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
    [wordFrequency release]

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = 1;
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    ```

2. Which of these objects is autoreleased?  Why?

            //Yes because there is no alloc or init
	1. `NSDate *yesterday = [NSDate date];`
	
            //No because it retains the init
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
            
            //no because it is being alloc/init
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    
            //no because of the new
	4. `NSDate *food = [NSDate new];`
    
            //no because it is being alloc/init
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
            //at first no but then yes because of the 'autorelease'
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`

3. Explain when you need to use the `NSAutoreleasePool`.

        //We need autoreleasePools because we might want do work with autoreleased objects
        //Having the pool alows use to work with those object before "draining" them all
        // in swift this is done for us...


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

#import "LSIPerson.h"

@implementation LSIPerson

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"LSIPerson.init");
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        NSLog(@"LSIPerson.init");
    }
    return self;
}

- (void)dealloc {
    [_name release];
    _name = nil;
    [super dealloc];
    NSLog(@"LSIPerson.dealloc");
}

- (void)setName:(NSString *)name {
    [_name release];
    _name = [name retain];
}

@end
```
