//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Tim on 15/07/2015.
//  Copyright © 2015 Timothy Hadwen. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotIntoSlotRows (slots: [[Slot]]) -> [[Slot]] {
        
        var slotRow1: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if(index == 0){
                    slotRow1.append(slot)
                } else if(index == 1) {
                    slotRow2.append(slot)
                } else if(index == 2){
                    slotRow3.append(slot)
                }
            }
        }
        
        return [slotRow1, slotRow2, slotRow3]
    }
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        
        var slotsInRows = unpackSlotIntoSlotRows(slots)
        var winnings = 0
        
        var flushWinCount = 0
        var threeOfAKindCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows {
            if(checkFlush(slotRow)){
                winnings++
                flushWinCount++
            }
            
            if(checkThreeInARow(slotRow)) {
                winnings += 1
                straightWinCount++
            }
            
            if checkThreeOfAKind(slotRow) {
                print("Three of a Kind")
                winnings += 3
                threeOfAKindCount += 1
            }
        }
        
        if flushWinCount == 3 {
            print("Royal flush")
            winnings += 15
        }
        
        if straightWinCount == 3 {
            print("Epic streak")
            winnings += 1000
        }
        
        if threeOfAKindCount == 3 {
            print("Threes all around")
            winnings += 50
        }
        
        print("Winnings \(winnings)")
        return winnings
        
    }
    
    class func checkFlush(slotRow: [Slot]) -> Bool{
        var redCount = 0
        var blackCount = 0
        
        for card in slotRow {
            if card.isRed {
                redCount++
            } else {
                blackCount++
            }
        }
        
        if(redCount == slotRow.count || blackCount == slotRow.count) {
            return true
        } else {
            return false
        }
    }
    
    class func checkThreeInARow(slotRow: [Slot]) -> Bool{
        if slotRow[0].value == slotRow[1].value - 1 && slotRow[0].value == slotRow[2].value - 2 {
            return true
        } else if slotRow[0].value == slotRow[1].value + 1 && slotRow[0].value == slotRow[2].value + 2 {
            return true
        } else {
            return false
        }
    }
    
    class func checkThreeOfAKind (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else {
            return false
        }
    }
    
}