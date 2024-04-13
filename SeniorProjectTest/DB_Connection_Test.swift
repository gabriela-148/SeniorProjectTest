//
//  DB_Connection_Test.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/8/24.
//

import Foundation
import SQLite3

class SQLiteDatabase {
    private var db: OpaquePointer?

    init(dbPath: String) {
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
        } else {
            print("Unable to open database. Verify that you created the database file or provided a valid path.")
        }
    }

    deinit {
        closeDatabase()
    }

    func closeDatabase() {
        if sqlite3_close(db) == SQLITE_OK {
            print("Successfully closed connection to database.")
        } else {
            print("Unable to close database.")
        }
    }

    // Add more functions for executing queries, fetching data, etc.
}

extension SQLiteDatabase {
    func executeQuery(query: String) -> Bool {
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }

        print("Error executing query: \(String(cString: sqlite3_errmsg(db)))")
        return false
    }

    // Add more functions for fetching data, handling transactions, etc.
}
