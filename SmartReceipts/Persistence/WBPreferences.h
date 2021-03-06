//
//  WBPreferences.h
//  SmartReceipts
//
//  Created on 27/03/14.
//  Copyright (c) 2014 Will Baumann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBPreferences : NSObject

+ (BOOL)predictCategories;
+ (void)setPredictCategories:(BOOL)predictCategories;

+ (BOOL)matchCommentToCategory;
+ (void)setMatchCommentToCategory:(BOOL)matchCommentToCategory;

+ (BOOL)matchNameToCategory;
+ (void)setMatchNameToCategory:(BOOL)matchNameToCategory;

+ (BOOL)onlyIncludeReimbursableReceiptsInReports;
+ (void)setOnlyIncludeReimbursableReceiptsInReports:(BOOL)onlyIncludeReimbursableReceiptsInReports;

+ (BOOL)includeTaxField;
+ (void)setIncludeTaxField:(BOOL)includeTaxField;

+ (NSString *)dateSeparator;
+ (void)setDateSeparator:(NSString *)dateSeparator;

+ (NSString *)defaultEmailRecipient;
+ (void)setDefaultEmailRecipient:(NSString *)defaultEmailReceipient;

+ (NSString *)defaultEmailCC;
+ (void)setDefaultEmailCC:(NSString *)value;

+ (NSString *)defaultEmailBCC;
+ (void)setDefaultEmailBCC:(NSString *)value;

+ (NSString *)defaultEmailSubject;
+ (void)setDefaultEmailSubject:(NSString *)value;

+ (NSString *)defaultCurrency;
+ (void)setDefaultCurrency:(NSString *)defaultCurrency;

+ (NSString *)userID;
+ (void)setUserID:(NSString *)userID;

+ (NSString *)fullName;
+ (void)setFullName:(NSString *)fullName;

+ (int)defaultTripDuration;
+ (void)setDefaultTripDuration:(int)defaultTripDuration;

+ (float)minimumReceiptPriceToIncludeInReports;
+ (void)setMinimumReceiptPriceToIncludeInReports:(float)minimumReceiptPriceToIncludeInReports;

+ (BOOL)defaultToFirstReportDate;
+ (void)setDefaultToFirstReportDate:(BOOL)defaultToFirstReportDate;

+ (BOOL)includeCSVHeaders;
+ (void)setIncludeCSVHeaders:(BOOL)includeCSVHeaders;

+ (BOOL)isTheDistancePriceBeIncludedInReports;
+ (void)setTheDistancePriceBeIncludedInReports:(BOOL)value;

+ (double)distanceRateDefaultValue;
+ (void)setDistanceRateDefaultValue:(double)value;

+ (float)defaultTaxPercentage;
+ (void)setDefaultTaxPercentage:(float)value;

+ (BOOL)enteredPricePreTax;
+ (void)setEnteredPricePreTax:(BOOL)value;

+ (BOOL)printDistanceTable;
+ (void)setPrintDistanceTable:(BOOL)value;

+ (BOOL)printDailyDistanceValues;
+ (void)setPrintDailyDistanceValues:(BOOL)value;

+ (BOOL)usePaymentMethods;
+ (void)setUsePaymentMethods:(BOOL)value;

+ (BOOL)trackCostCenter;
+ (void)setTrackCostCenter:(BOOL)value;

+ (BOOL)showReceiptID;
+ (void)setShowReceiptID:(BOOL)value;

+ (BOOL)printReceiptIDByPhoto;
+ (void)setPrintReceiptIDByPhoto:(BOOL)value;

+ (BOOL)printCommentByPhoto;
+ (void)setPrintCommentByPhoto:(BOOL)value;

+ (BOOL)printReceiptTableLandscape;
+ (void)setPrintReceiptTableLandscape:(BOOL)value;

+ (BOOL)layoutShowReceiptDate;
+ (void)setLayoutShowReceiptDate:(BOOL)value;

+ (BOOL)layoutShowReceiptCategory;
+ (void)setLayoutShowReceiptCategory:(BOOL)value;

+ (BOOL)layoutShowReceiptAttachmentMarker;
+ (void)setLayoutShowReceiptAttachmentMarker:(BOOL)value;

+ (NSInteger)cameraMaxHeightWidth;
+ (void)setCameraMaxHeightWidth:(NSInteger)cameraMaxHeightWidth;

+ (BOOL)cameraSaveImagesBlackAndWhite;
+ (void)setCameraSaveImagesBlackAndWhite:(BOOL)value;

+ (BOOL)cameraRotateImage;
+ (void)setCameraRotateImage:(BOOL)value;

+ (BOOL)isAutocompleteEnabled;
+ (void)setAutocompleteEnabled:(BOOL)value;

+ (BOOL)allowDataEntryOutsideTripBounds;
+ (void)setAllowDataEntryOutsideTripBounds:(BOOL)value;

+ (NSString *)pdfFooterString;
+ (void)setPDFFooterString:(NSString *)string;

+ (void)save;

+ (float)MIN_FLOAT;

+ (void)setFromXmlString:(NSString *)xmlString;
+ (NSString *)xmlString;

+ (BOOL)assumeFullPage;
+ (void)setAssumeFullPage:(BOOL)value;

@end
