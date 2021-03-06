#import "UITableView+LMIndexChangeSets.h"

@implementation UITableView (LMIndexChangeSets)

- (void) updateSection:(NSInteger)section
         withChangeSet:(NSDictionary*)indexChangeSet
{
    [indexChangeSet[@"deleted"] enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:idx inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [indexChangeSet[@"inserted"] enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:idx inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [indexChangeSet[@"moved"] enumerateKeysAndObjectsUsingBlock:^(NSNumber* fromIndex, NSNumber* toIndex, BOOL *stop) {
        [self moveRowAtIndexPath:[NSIndexPath indexPathForItem:[fromIndex integerValue] inSection:section]
                               toIndexPath:[NSIndexPath indexPathForItem:[toIndex integerValue] inSection:section]];
    }];
}

@end
