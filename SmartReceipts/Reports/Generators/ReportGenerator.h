//
//  ReportGenerator.h
//  SmartReceipts
//
//  Created by Jaanus Siim on 25/04/15.
//  Copyright (c) 2015 Will Baumann. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBTrip;
@class Database;

@interface ReportGenerator : NSObject

@property (nonatomic, strong, readonly) WBTrip *trip;
@property (nonatomic, strong, readonly) Database *database;

- (instancetype)initWithTrip:(WBTrip *)trip database:(Database *)database;
- (BOOL)generateToPath:(NSString *)outputPath;
- (NSArray *)receiptColumns;
- (NSArray *)receipts;
- (NSArray *)distanceColumns;
- (NSArray *)distances;

@end
