# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

Yes

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // *** Leak here *** punctuationSet was never released after taking ownership by calling retain

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // *** Leak here *** We own this object but never release it, it's another leak

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		} // *** Leak Here *** This alloc init is another leak b/c it hasn't been released
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```
    
    
    2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";


    NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[NSNumber numberWithInt:1];
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    ```
    



2. Which of these objects is autoreleased?  Why? 

    Examples 1 and 6
    
    1 b/c we don't have ownership from alloc/init, new, copy or mutableCopy and 6 b/c of the autorelease declaration at the end of the method line. We have ownership of the ohter examples b/c of alloc/init, copy or retain so they will not be autoreleased

	1. `NSDate *yesterday = [NSDate date];` 
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`

3. Explain when you need to use the `NSAutoreleasePool`.

It would be good to use AutoreleasePool when you are doing expensive work that takes a lot of memory by creating lots of temporary objects, like in for loops. 

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```
```objc

@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

- (instancetype)personWithName:(NSString *)name;

@end

@implementation LSIPerson

- (instancetype)initWithName::(NSString *)name
{

}

- (instancetype)personWithName:(NSString *)name
{
    return [[[LSIPerson alloc] initWithName:name] autorelease];
}

@end
```
