//
//  Sqlite3Class.swift
//  HYU_TT
//
//  Created by 김영호 on 2017. 6. 7..
//  Copyright © 2017년 김나용. All rights reserved.
//

import Foundation
import SQLite

class DatabaseManagement {
    static let MakedServeralTables:DatabaseManagement = DatabaseManagement(DBName: "MakedDB")
    static let SeletedTable:DatabaseManagement = DatabaseManagement(DBName: "SelectedDB")
    
    private let db: Connection?
    
    private let makedSubjectsTable = Table("MakedSubjectsTable")
    private let choosenSubjectsTable = Table("choosenSubjectsTable")
    private let id = Expression<Int64>("id")
    private let idForTable = Expression<Int>("idForTable")
    private let grade = Expression<String>("grade")
    private let kindOfComplete = Expression<String>("kindOfComplete")
    private let number = Expression<String>("number")
    private let numberOfLecture = Expression<String>("numberOfLecture")
    private let nameOfLecture = Expression<String>("nameOfLecture")
    private let credit = Expression<String>("credit")
    private let theoryOrPractice = Expression<String>("theoryOrPractice")
    private let time = Expression<String>("time")
    private let place = Expression<String>("place")
    private let professor = Expression<String>("professor")
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/mysubjects.sqlite3")
            createTableProduct()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    init(DBName : String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/\(DBName).sqlite3")
            createTableProduct()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    func createTableProduct() {
        do {
            
            try db!.run(makedSubjectsTable.create(ifNotExists: true) { table in
//                table.column(id, primaryKey: true)
                table.column(idForTable)
                table.column(grade)
                table.column(kindOfComplete)
                table.column(number)
                table.column(numberOfLecture)
                table.column(nameOfLecture)
                table.column(credit)
                table.column(theoryOrPractice)
                table.column(time)
                table.column(place)
                table.column(professor)
                
            })
            print("create table successfully")
        } catch {
            print("Unable to create table")
        }
        do {
            
            try db!.run(choosenSubjectsTable.create(ifNotExists: true) { table in
                table.column(grade)
                table.column(kindOfComplete)
                table.column(number)
                table.column(numberOfLecture)
                table.column(nameOfLecture)
                table.column(credit)
                table.column(theoryOrPractice)
                table.column(time)
                table.column(place)
                table.column(professor)
            })
            print("create table successfully")
        } catch {
            print("Unable to create table")
        }
    }
    
    func addSubject(subject : Subject, index : Int) {
        for indexForTime in 0..<subject.time.count {
            do {
                let insert = makedSubjectsTable.insert(idForTable <- index, grade <- subject.grade, kindOfComplete <- subject.kindOfComplete, number <- subject.number, numberOfLecture <- subject.numberOfLecture, nameOfLecture <- subject.nameOfLecture, credit <- subject.credit, theoryOrPractice <- subject.theoryOrPractice, time <- subject.time[indexForTime], place <- subject.place, professor <- subject.professor[indexForTime])
                try db!.run(insert)
            } catch {
                print("Cannot insert to database")
                return
            }
        }
    }
    
    func queryAllProduct() -> [[Subject]] {
        var result :[[Subject]] = []
        var subjects : [Subject] = []
        var beforeNumberOfLecture:String = ""
        var tempSubject = Subject()
        var isFirstRowInTable = true
        var isFirstRowInDB = true
        var tempIdForTable:Int = -1
        do {
            for subject in try db!.prepare(self.makedSubjectsTable) {
                
                if (tempIdForTable != subject[idForTable]) {
                    if (isFirstRowInDB)
                    { isFirstRowInDB = false }
                    else {
                        subjects.append(tempSubject)
                        result.append(subjects)
                    }
                        isFirstRowInTable = true
                        beforeNumberOfLecture = ""
                        subjects = []
                        tempIdForTable = subject[idForTable]
                }
                
                if (subject[numberOfLecture] != beforeNumberOfLecture) {
                    if (isFirstRowInTable) { isFirstRowInTable = false }
                    else { subjects.append(tempSubject) }
                    
                    tempSubject = Subject(grade: subject[grade], kindOfComplete: subject[kindOfComplete], number: subject[number], numberOfLecture: subject[numberOfLecture], nameOfLecture: subject[nameOfLecture], credit: subject[credit], theoryOrPractice: subject[theoryOrPractice], time: subject[time], place: subject[place], professor: subject[professor])
                    beforeNumberOfLecture = subject[numberOfLecture]

                }
                else {
                    tempSubject.time.append(subject[time])
                    tempSubject.professor.append(subject[professor])
                }
            }
            subjects.append(tempSubject)
            result.append(subjects)
            
        } catch {
            print("Cannot get list of product")
        }

        return result
    }
    

    func deleteTalbe() -> Bool {
        do {
            try db!.run(makedSubjectsTable.delete())
            print("delete sucessfully")
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
}



