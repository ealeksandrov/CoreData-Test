// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Message.h instead.

#import <CoreData/CoreData.h>


extern const struct MessageAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *messageStr;
} MessageAttributes;

extern const struct MessageRelationships {
} MessageRelationships;

extern const struct MessageFetchedProperties {
} MessageFetchedProperties;





@interface MessageID : NSManagedObjectID {}
@end

@interface _Message : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MessageID*)objectID;





@property (nonatomic, strong) NSDate* creationDate;



//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* messageStr;



//- (BOOL)validateMessageStr:(id*)value_ error:(NSError**)error_;






@end

@interface _Message (CoreDataGeneratedAccessors)

@end

@interface _Message (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;




- (NSString*)primitiveMessageStr;
- (void)setPrimitiveMessageStr:(NSString*)value;




@end
