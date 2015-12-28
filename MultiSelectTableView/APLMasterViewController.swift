//
//  APLMasterViewController.swift
//  MultiSelectTableView
//
//  Created by 開発 on 2015/12/28.
//  Copyright © 2015 Apple Inc. All rights reserved.
//
///*
//     File: APLMasterViewController.h
//     File: APLMasterViewController.m
// Abstract: UITableViewController subclass for managing the table and other UI.
//  Version: 2.2
//
// Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
// Inc. ("Apple") in consideration of your agreement to the following
// terms, and your use, installation, modification or redistribution of
// this Apple software constitutes acceptance of these terms.  If you do
// not agree with these terms, please do not use, install, modify or
// redistribute this Apple software.
//
// In consideration of your agreement to abide by the following terms, and
// subject to these terms, Apple grants you a personal, non-exclusive
// license, under Apple's copyrights in this original Apple software (the
// "Apple Software"), to use, reproduce, modify and redistribute the Apple
// Software, with or without modifications, in source and/or binary forms;
// provided that if you redistribute the Apple Software in its entirety and
// without modifications, you must retain this notice and the following
// text and disclaimers in all such redistributions of the Apple Software.
// Neither the name, trademarks, service marks or logos of Apple Inc. may
// be used to endorse or promote products derived from the Apple Software
// without specific prior written permission from Apple.  Except as
// expressly stated in this notice, no other rights or licenses, express or
// implied, are granted by Apple herein, including but not limited to any
// patent rights that may be infringed by your derivative works or by other
// works in which the Apple Software may be incorporated.
//
// The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
// MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
// THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
// OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
//
// IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
// OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
// MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
// AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
// STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
// Copyright (C) 2014 Apple Inc. All Rights Reserved.
//
// */
//
//#import <UIKit/UIKit.h>
import UIKit
//
//@interface APLMasterViewController : UITableViewController
@objc(APLMasterViewController)
class APLMasterViewController: UITableViewController, UIActionSheetDelegate {
//
//@end
//
//#import "APLMasterViewController.h"
//
//@interface APLMasterViewController () <UIActionSheetDelegate>
//
///*
// These outlets to the buttons use a `strong` reference instead of `weak` because we want
// to keep the buttons around even if they're not inside a view.
// */
//@property (nonatomic, strong) IBOutlet UIBarButtonItem *editButton;
    @IBOutlet var editButton: UIBarButtonItem!
//@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
    @IBOutlet var cancelButton: UIBarButtonItem!
//@property (nonatomic, strong) IBOutlet UIBarButtonItem *deleteButton;
    @IBOutlet var deleteButton: UIBarButtonItem!
//@property (nonatomic, strong) IBOutlet UIBarButtonItem *addButton;
    @IBOutlet var addButton: UIBarButtonItem!
//
//// A simple array of strings for the data model.
//@property (nonatomic, strong) NSMutableArray *dataArray;
    var dataArray: [String] = []
//
//@end
//
//
//#pragma mark -
//
//@implementation APLMasterViewController
//
//- (void)viewDidLoad
    override func viewDidLoad() {
//{
//	[super viewDidLoad];
        super.viewDidLoad()
//
//    /*
//     This option is also selected in the storyboard. Usually it is better to configure a table view in a xib/storyboard, but we're redundantly configuring this in code to demonstrate how to do that.
//     */
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
        self.tableView.allowsMultipleSelectionDuringEditing = true
//
//    // populate the data array with some example objects
//    self.dataArray = [NSMutableArray new];
        self.dataArray = []
//    NSString *itemFormatString = NSLocalizedString(@"Item %d", @"Format string for item");
        let itemFormatString = NSLocalizedString("Item %d", comment: "Format string for item")
//    for (unsigned int itemNumber = 1; itemNumber <= 12; itemNumber++)
//    {
        for itemNumber in 1...12 {
//        NSString *itemName = [NSString stringWithFormat:itemFormatString, itemNumber];
            let itemName = String(format: itemFormatString, Int32(itemNumber))
//        [self.dataArray addObject:itemName];
            self.dataArray.append(itemName)
//    }
        }
//
//    // make our view consistent
//    [self updateButtonsToMatchTableState];
        self.updateButtonsToMatchTableState()
//}
    }
//
//
//#pragma mark - UITableViewDelegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//	return self.dataArray.count;
        return self.dataArray.count
//}
    }
//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//    // Update the delete button's title based on how many items are selected.
//    [self updateDeleteButtonTitle];
        self.updateDeleteButtonTitle()
//}
    }
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    // Update the delete button's title based on how many items are selected.
//    [self updateButtonsToMatchTableState];
        self.updateButtonsToMatchTableState()
//}
    }
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    // Configure a cell to show the corresponding string from the array.
//    static NSString *kCellID = @"cellID";
        let kCellID = "cellID"
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID)!
//	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel!.text = self.dataArray[indexPath.row]
//
//	return cell;
        return cell
//}
    }
//
//
//#pragma mark - Action methods
//
//- (IBAction)editAction:(id)sender
//{
    @IBAction func editAction(_: AnyObject) {
//    [self.tableView setEditing:YES animated:YES];
        self.tableView.setEditing(true, animated: true)
//    [self updateButtonsToMatchTableState];
        self.updateButtonsToMatchTableState()
//}
    }
//
//- (IBAction)cancelAction:(id)sender
//{
    @IBAction func cancelAction(_: AnyObject) {
//    [self.tableView setEditing:NO animated:YES];
        self.tableView.setEditing(false, animated: true)
//    [self updateButtonsToMatchTableState];
        self.updateButtonsToMatchTableState()
//}
    }
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        actionSheetClickedButtonAtIndex(buttonIndex)
    }
    func actionSheetClickedButtonAtIndex(buttonIndex: Int) {
//	// The user tapped one of the OK/Cancel buttons.
//	if (buttonIndex == 0)
//	{
        if buttonIndex == 0 {
//		// Delete what the user selected.
//        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
            let selectedRows = self.tableView.indexPathsForSelectedRows!
//        BOOL deleteSpecificRows = selectedRows.count > 0;
            let deleteSpecificRows = selectedRows.count > 0
//        if (deleteSpecificRows)
//        {
            if deleteSpecificRows {
//            // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
//            NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
                let indicesOfItemsToDelete = NSMutableIndexSet()
//            for (NSIndexPath *selectionIndex in selectedRows)
//            {
                for selectionIndex in selectedRows {
//                [indicesOfItemsToDelete addIndex:selectionIndex.row];
                    indicesOfItemsToDelete.addIndex(selectionIndex.row)
//            }
                }
//            // Delete the objects from our data model.
//            [self.dataArray removeObjectsAtIndexes:indicesOfItemsToDelete];
                self.dataArray = self.dataArray.enumerate().lazy.filter {(index,_) in
                    !indicesOfItemsToDelete.containsIndex(index)
                }.map{(_,element) in element}
//
//            // Tell the tableView that we deleted the objects
//            [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
                self.tableView.deleteRowsAtIndexPaths(selectedRows, withRowAnimation: .Automatic)
//        }
//        else
//        {
            } else {
//            // Delete everything, delete the objects from our data model.
//            [self.dataArray removeAllObjects];
                self.dataArray.removeAll()
//
//            // Tell the tableView that we deleted the objects.
//            // Because we are deleting all the rows, just reload the current table section
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
//        }
            }
//
//        // Exit editing mode after the deletion.
//        [self.tableView setEditing:NO animated:YES];
            self.tableView.setEditing(false, animated: true)
//        [self updateButtonsToMatchTableState];
            self.updateButtonsToMatchTableState()
//	}
        }
//}
    }
//
//- (IBAction)deleteAction:(id)sender
//{
    @IBAction func deleteAction(_: AnyObject) {
//    // Open a dialog with just an OK button.
//	NSString *actionTitle;
        let actionTitle: String
//    if (([[self.tableView indexPathsForSelectedRows] count] == 1)) {
        if self.tableView.indexPathsForSelectedRows?.count ?? 0 == 1 {
//        actionTitle = NSLocalizedString(@"Are you sure you want to remove this item?", @"");
            actionTitle = NSLocalizedString("Are you sure you want to remove this item?", comment: "")
//    }
//    else
//    {
        } else {
//        actionTitle = NSLocalizedString(@"Are you sure you want to remove these items?", @"");
            actionTitle = NSLocalizedString("Are you sure you want to remove these items?", comment: "")
//    }
        }
//
//    NSString *cancelTitle = NSLocalizedString(@"Cancel", @"Cancel title for item removal action");
        let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel title for item removal action")
//    NSString *okTitle = NSLocalizedString(@"OK", @"OK title for item removal action");
        let okTitle = NSLocalizedString("OK", comment: "OK title for item removal action")
        if #available(iOS 8.0, *) {
            let actionAlert = UIAlertController(title: actionTitle, message: nil, preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: cancelTitle, style: .Cancel) {_ in
                self.actionSheetClickedButtonAtIndex(1)
            }
            let okAction = UIAlertAction(title: okTitle, style: .Destructive) {_ in
                self.actionSheetClickedButtonAtIndex(0)
            }
            actionAlert.addAction(cancelAction)
            actionAlert.addAction(okAction)
            self.presentViewController(actionAlert, animated: true, completion: nil)
        } else {
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle
            let actionSheet = UIActionSheet(title: actionTitle,
                delegate: self,
                cancelButtonTitle: cancelTitle,
                destructiveButtonTitle: okTitle)
//                                                             delegate:self
//                                                    cancelButtonTitle:cancelTitle
//                                               destructiveButtonTitle:okTitle
//                                                    otherButtonTitles:nil];
//
//	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            actionSheet.actionSheetStyle = UIActionSheetStyle.Default
//
//    // Show from our table view (pops up in the middle of the table).
//	[actionSheet showInView:self.view];
            actionSheet.showInView(self.view)
        }
//}
    }
//
//- (IBAction)addAction:(id)sender
//{
    @IBAction func addAction(_: AnyObject) {
//    // Tell the tableView we're going to add (or remove) items.
//    [self.tableView beginUpdates];
        self.tableView.beginUpdates()
//
//    // Add an item to the array.
//    [self.dataArray addObject:@"New Item"];
        self.dataArray.append("New Item")
//
//    // Tell the tableView about the item that was added.
//    NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0];
        let indexPathOfNewItem = NSIndexPath(forRow: (self.dataArray.count - 1), inSection: 0)
//    [self.tableView insertRowsAtIndexPaths:@[indexPathOfNewItem]
        self.tableView.insertRowsAtIndexPaths([indexPathOfNewItem], withRowAnimation: .Automatic)
//                          withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    // Tell the tableView we have finished adding or removing items.
//    [self.tableView endUpdates];
        self.tableView.endUpdates()
//
//    // Scroll the tableView so the new item is visible
//    [self.tableView scrollToRowAtIndexPath:indexPathOfNewItem
        self.tableView.scrollToRowAtIndexPath(indexPathOfNewItem, atScrollPosition: .Bottom, animated: true)
//                          atScrollPosition:UITableViewScrollPositionBottom
//                                  animated:YES];
//
//    // Update the buttons if we need to.
//    [self updateButtonsToMatchTableState];
        self.updateButtonsToMatchTableState()
//}
    }
//
//
//#pragma mark - Updating button state
//
//- (void)updateButtonsToMatchTableState
//{
    private func updateButtonsToMatchTableState() {
//    if (self.tableView.editing)
//    {
        if self.tableView.editing {
//        // Show the option to cancel the edit.
//        self.navigationItem.rightBarButtonItem = self.cancelButton;
            self.navigationItem.rightBarButtonItem = self.cancelButton
//
//        [self updateDeleteButtonTitle];
            self.updateDeleteButtonTitle()
//
//        // Show the delete button.
//        self.navigationItem.leftBarButtonItem = self.deleteButton;
            self.navigationItem.leftBarButtonItem = self.deleteButton
//    }
//    else
//    {
        } else {
//        // Not in editing mode.
//        self.navigationItem.leftBarButtonItem = self.addButton;
            self.navigationItem.leftBarButtonItem = self.addButton
//
//        // Show the edit button, but disable the edit button if there's nothing to edit.
//        if (self.dataArray.count > 0)
//        {
            self.editButton.enabled = !self.dataArray.isEmpty
//            self.editButton.enabled = YES;
//        }
//        else
//        {
//            self.editButton.enabled = NO;
//        }
//        self.navigationItem.rightBarButtonItem = self.editButton;
            self.navigationItem.rightBarButtonItem = self.editButton
//    }
        }
//}
    }
//
//- (void)updateDeleteButtonTitle
//{
    private func updateDeleteButtonTitle() {
//    // Update the delete button's title, based on how many items are selected
//    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        let selectedRows = self.tableView.indexPathsForSelectedRows ?? []
//
//    BOOL allItemsAreSelected = selectedRows.count == self.dataArray.count;
        let allItemsAreSelected = selectedRows.count == self.dataArray.count
//    BOOL noItemsAreSelected = selectedRows.count == 0;
        let noItemsAreSelected = selectedRows.isEmpty
//
//    if (allItemsAreSelected || noItemsAreSelected)
//    {
        if allItemsAreSelected || noItemsAreSelected {
//        self.deleteButton.title = NSLocalizedString(@"Delete All", @"");
            self.deleteButton.title = NSLocalizedString("Delete All", comment: "")
//    }
//    else
//    {
        } else {
//        NSString *titleFormatString =
            let titleFormatString =
//            NSLocalizedString(@"Delete (%d)", @"Title for delete button with placeholder for number");
            NSLocalizedString("Delete (%d)", comment: "Title for delete button with placeholder for number")
//        self.deleteButton.title = [NSString stringWithFormat:titleFormatString, selectedRows.count];
            self.deleteButton.title = String(format: titleFormatString, Int32(selectedRows.count))
//    }
        }
//}
    }
//
//@end
}