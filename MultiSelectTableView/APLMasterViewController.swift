//
//  APLMasterViewController.swift
//  MultiSelectTableView
//
//  Created by 開発 on 2015/12/28.
//  Copyright © 2015 Apple Inc. All rights reserved.
//
/*
     File: APLMasterViewController.h
     File: APLMasterViewController.m
 Abstract: UITableViewController subclass for managing the table and other UI.
  Version: 2.2

 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.

 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.

 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.

 Copyright (C) 2014 Apple Inc. All Rights Reserved.

 */

import UIKit

@objc(APLMasterViewController)
class APLMasterViewController: UITableViewController, UIActionSheetDelegate {
    
    /*
     These outlets to the buttons use a `strong` reference instead of `weak` because we want
     to keep the buttons around even if they're not inside a view.
     */
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var deleteButton: UIBarButtonItem!
    @IBOutlet var addButton: UIBarButtonItem!
    
    // A simple array of strings for the data model.
    var dataArray: [String] = []
    
    
    //MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         This option is also selected in the storyboard. Usually it is better to configure a table view in a xib/storyboard, but we're redundantly configuring this in code to demonstrate how to do that.
         */
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        // populate the data array with some example objects
        self.dataArray = []
        let itemFormatString = NSLocalizedString("Item %d", comment: "Format string for item")
        for itemNumber in 1...12 {
            let itemName = String(format: itemFormatString, Int32(itemNumber))
            self.dataArray.append(itemName)
        }
        
        // make our view consistent
        self.updateButtonsToMatchTableState()
    }
    
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // Update the delete button's title based on how many items are selected.
        self.updateDeleteButtonTitle()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update the delete button's title based on how many items are selected.
        self.updateButtonsToMatchTableState()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure a cell to show the corresponding string from the array.
        let kCellID = "cellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellID)!
        cell.textLabel!.text = self.dataArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK: - Action methods
    
    @IBAction func editAction(_: AnyObject) {
        self.tableView.setEditing(true, animated: true)
        self.updateButtonsToMatchTableState()
    }
    
    @IBAction func cancelAction(_: AnyObject) {
        self.tableView.setEditing(false, animated: true)
        self.updateButtonsToMatchTableState()
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        actionSheetClickedButtonAtIndex(buttonIndex)
    }
    func actionSheetClickedButtonAtIndex(_ buttonIndex: Int) {
        // The user tapped one of the OK/Cancel buttons.
        if buttonIndex == 0 {
            // Delete what the user selected.
            let selectedRows = self.tableView.indexPathsForSelectedRows!
            let deleteSpecificRows = selectedRows.count > 0
            if deleteSpecificRows {
                // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
                //let indicesOfItemsToDelete = NSMutableIndexSet()
                var indicesOfItemsToDelete = IndexSet()
                for selectionIndex in selectedRows {
                    indicesOfItemsToDelete.insert(selectionIndex.row)
                }
                // Delete the objects from our data model.
                self.dataArray = self.dataArray.enumerated().lazy.filter {(index,_) in
                    !indicesOfItemsToDelete.contains(index)
                    }.map{(_,element) in element}
                
                // Tell the tableView that we deleted the objects
                self.tableView.deleteRows(at: selectedRows, with: .automatic)
            } else {
                // Delete everything, delete the objects from our data model.
                self.dataArray.removeAll()
                
                // Tell the tableView that we deleted the objects.
                // Because we are deleting all the rows, just reload the current table section
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
            
            // Exit editing mode after the deletion.
            self.tableView.setEditing(false, animated: true)
            self.updateButtonsToMatchTableState()
        }
    }
    
    @IBAction func deleteAction(_: AnyObject) {
        // Open a dialog with just an OK button.
        let actionTitle: String
        if self.tableView.indexPathsForSelectedRows?.count ?? 0 == 1 {
            actionTitle = NSLocalizedString("Are you sure you want to remove this item?", comment: "")
        } else {
            actionTitle = NSLocalizedString("Are you sure you want to remove these items?", comment: "")
        }
        
        let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel title for item removal action")
        let okTitle = NSLocalizedString("OK", comment: "OK title for item removal action")
        let actionAlert = UIAlertController(title: actionTitle, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) {_ in
            self.actionSheetClickedButtonAtIndex(1)
        }
        let okAction = UIAlertAction(title: okTitle, style: .destructive) {_ in
            self.actionSheetClickedButtonAtIndex(0)
        }
        actionAlert.addAction(cancelAction)
        actionAlert.addAction(okAction)
        self.present(actionAlert, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_: AnyObject) {
        // Tell the tableView we're going to add (or remove) items.
        self.tableView.beginUpdates()
        
        // Add an item to the array.
        self.dataArray.append("New Item")
        
        // Tell the tableView about the item that was added.
        let indexPathOfNewItem = IndexPath(row: (self.dataArray.count - 1), section: 0)
        self.tableView.insertRows(at: [indexPathOfNewItem], with: .automatic)
        
        // Tell the tableView we have finished adding or removing items.
        self.tableView.endUpdates()
        
        // Scroll the tableView so the new item is visible
        self.tableView.scrollToRow(at: indexPathOfNewItem, at: .bottom, animated: true)
        
        // Update the buttons if we need to.
        self.updateButtonsToMatchTableState()
    }
    
    
    //MARK: - Updating button state
    
    private func updateButtonsToMatchTableState() {
        if self.tableView.isEditing {
            // Show the option to cancel the edit.
            self.navigationItem.rightBarButtonItem = self.cancelButton
            
            self.updateDeleteButtonTitle()
            
            // Show the delete button.
            self.navigationItem.leftBarButtonItem = self.deleteButton
        } else {
            // Not in editing mode.
            self.navigationItem.leftBarButtonItem = self.addButton
            
            // Show the edit button, but disable the edit button if there's nothing to edit.
            self.editButton.isEnabled = !self.dataArray.isEmpty
            self.navigationItem.rightBarButtonItem = self.editButton
        }
    }
    
    private func updateDeleteButtonTitle() {
        // Update the delete button's title, based on how many items are selected
        let selectedRows = self.tableView.indexPathsForSelectedRows ?? []
        
        let allItemsAreSelected = selectedRows.count == self.dataArray.count
        let noItemsAreSelected = selectedRows.isEmpty
        
        if allItemsAreSelected || noItemsAreSelected {
            self.deleteButton.title = NSLocalizedString("Delete All", comment: "")
        } else {
            let titleFormatString =
                NSLocalizedString("Delete (%d)", comment: "Title for delete button with placeholder for number")
            self.deleteButton.title = String(format: titleFormatString, Int32(selectedRows.count))
        }
    }
    
}
