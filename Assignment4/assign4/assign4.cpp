// comp3311-project.cpp : Defines entry point for the console application.
// No marks will be given if we cannot compile your submitted .cpp file in VS 2019.
// No marks will be given if the embedded SQL statements are incorrect and no partial credits will be given.
// No marks will be given for a TODO task if it fails to get the correct result from our check cases (6 TODO tasks in total).

#include <windows.h>
#include <sql.h>
#include <sqlext.h>
#include <sqltypes.h>
#include <iostream>
#include <conio.h>
#include <iomanip>
using namespace std;

#ifdef _MSC_VER
#define getch() _getch()
#endif


HENV   henv;
HDBC   hdbc;
HSTMT  hstmt;
RETCODE	ret;

SQLLEN cbStaffId; // global variables
SQLINTEGER staff_id;


boolean ConnectDB();
void DisconnectDB();
boolean userLogin();


void prof_menu(); // the menu for prof.
void teachInfo(); // show teaching information
void superInfo(); // show supervision information
void adminInfo(); // show administrative information

void showTeach(); // show offerings being taught by the prof
void showTAs();  // show offerings being led by the prof
void showPre();   // show prerequisites of all the courses
void showSuper(); // show students being supervised by the prof
void showSuperGroup(); // show supervision information of the school
void addPhone();       // add a new phone for the prof

void printRecordIntoCol(HSTMT stmt);
SQLCHAR*** printIntoRow(HSTMT stmt, int maxColumnWidth);


int main() {
	int command = 0;
	// set the width and line displayed in the command prompt
	system("mode con cols=80 lines=50");

	if (ConnectDB()) {
		while (userLogin()) {
			do {
				system("CLS"); // clear the screen
				prof_menu(); //menu for the prof

			} while (command != 0);
		}
	}
	else {
		cout << "Oracle Connection unsuccessful.\n";
		system("pause");
	}
	DisconnectDB();
}


void prof_menu() {

	int command = 0;
	int ISdone = 0;

	while (!ISdone) {
		system("CLS"); // Clear the screen
		cout << "============ Information System for Professors ===============\n\n";
		cout << "0. Return to the previous menu                     (input '0').\n";
		cout << "1. Show Teaching related information               (input '1').\n";
		cout << "2. Show Supervision information                    (input '2').\n";
		cout << "3. Show Administrative information                 (input '3').\n";
		cout << "Please enter your choice: ";

		cin >> command;

		char buf[2];
		cin.getline(buf, 2); // grab the endline character when the user press "Enter"

		cout << endl;

		switch (command) {
		case 1:
			teachInfo();
			ISdone = 0;
			break;

		case 2:
			superInfo();
			ISdone = 0;
			break;
		case 3:
			adminInfo();
			ISdone = 0;
			break;
		case 0:
			ISdone = 1;
			break;
		default:
			break;
		}
	}
}


void teachInfo() {

	int command = 0;
	int ISdone = 0;

	while (!ISdone) {
		system("CLS");
		cout << "=================== Teaching Information ======================\n\n";
		cout << "0. Return to the previous menu                        (input '0').\n";
		cout << "1. Display course(s) teaching                         (input '1').\n";
		cout << "2. Display TAs prefered by the staff                  (input '2').\n";
		cout << "3. See prerequisites of the courses                   (input '3').\n";
		cout << "Please enter your choice: ";

		cin >> command;

		char buf[2];
		cin.getline(buf, 2); // grab the endline character when the user press "Enter"

		cout << endl;

		switch (command) {
		case 1:
			showTeach();
			ISdone = 0;
			break;

		case 2:
			showTAs();
			ISdone = 0;
			break;
		case 3:
			showPre();
			ISdone = 0;
			break;
		case 0:
			ISdone = 1;
			break;
		default:
			break;
		}
	}

}

void showTeach() {
	SQLAllocStmt(hdbc, &hstmt);
	char query[1000];

	system("CLS");

	cout << "Here are the courses you are teaching:\n";

	// TODO 1: display the course_ID, course_name, offering_no, classroom, no_of_stds of all the courses he/she is teaching.
	// for the expect behaviour of this part please refer to the executable program
	// Add your code here
	sprintf_s(query, "SELECT course_ID, course_name, offering_no, classroom, no_of_stds FROM (prof_teach NATURAL JOIN offering) NATURAL JOIN course WHERE staff_id = %d;", staff_id);
	SQLExecDirectA(hstmt, (SQLCHAR*) query, SQL_NTS);

	printIntoRow(hstmt, 20);

	SQLFreeStmt(hstmt, SQL_CLOSE);
	cout << endl;

	system("pause");
}

void showTAs() {
	SQLAllocStmt(hdbc, &hstmt);
	char query[1000];

	system("CLS");
	cout << "Here are the TAs prefered by the staff:\n";

	// TODO 2: displays TAs information(the student_ID, last_name, first_name, and phone number) who are prefer by professor he/she
	// Add your code here

	sprintf_s(query, "SELECT student_ID, last_name, first_name, phone FROM pref_ta NATURAL JOIN ta WHERE staff_id = %d;", staff_id);
	SQLExecDirectA(hstmt, (SQLCHAR*)query, SQL_NTS);

	printIntoRow(hstmt, 20);
	
	SQLFreeStmt(hstmt, SQL_CLOSE);
	system("pause");
}
void showPre() {
	SQLAllocStmt(hdbc, &hstmt);
	char query[1000];

	system("CLS");
	cout << "Here are the prerequisites of the courses:\n";

	// TODO 3: group the prerequisites (course_IDs) by the course_IDs of the main courses and display the prerequisites (course_ID) in a list. See the screen shot in the assignment output section for the expected output.
	// Hint: you will find the aggregate function LISTAGG() function useful. You can refer to http://www.oracle-developer.net/display.php?id=515 for the exact syntax of LISTAGG().
	// Add your code here
	strcpy_s(query, "SELECT main_course_id, LISTAGG(prereq_course_id, ',') FROM prerequisite GROUP BY main_course_id;");
	SQLExecDirectA(hstmt, (SQLCHAR*)query, SQL_NTS);

	printIntoRow(hstmt, 20);

	SQLFreeStmt(hstmt, SQL_CLOSE);

	system("pause");
}


void superInfo() {

	int command = 0;
	int ISdone = 0;

	while (!ISdone) {
		system("CLS");
		cout << "=================== Supervision Information ======================\n\n";
		cout << "0. Return to the previous menu                        (input '0').\n";
		cout << "1. Display students being supervised                  (input '1').\n";
		cout << "2. Display students by their supervisor staff_ID      (input '2').\n";
		cout << "Please enter your choice: ";

		cin >> command;

		char buf[2];
		cin.getline(buf, 2); // grab the endline character when the user press "Enter"

		cout << endl;

		switch (command) {
		case 1:
			showSuper();
			ISdone = 0;
			break;

		case 2:
			system("mode con cols=160 lines=50"); //make the screen larger
			showSuperGroup();
			system("mode con cols=80 lines=50"); //restore the screen size
			ISdone = 0;
			break;
		case 0:
			ISdone = 1;
			break;
		default:
			break;
		}
	}
}

void showSuper() {

	SQLAllocStmt(hdbc, &hstmt);
	char query[1000];

	system("CLS");
	cout << "Here are the students you are supervising:\n";

	// TODO 4: display all the student_ID, fullname (in TA table) of all the students the professor supervises.
	// Add your code here

	sprintf_s(query, "SELECT student_id, first_name || ',' || last_name AS fullname FROM supervise NATURAL JOIN ta WHERE staff_id = %d; ", staff_id);
	SQLExecDirectA(hstmt, (SQLCHAR*)query, SQL_NTS);

	printIntoRow(hstmt, 20);

	SQLFreeStmt(hstmt, SQL_CLOSE);
	system("pause");
}

void showSuperGroup() {


	SQLAllocStmt(hdbc, &hstmt);
	char query[1000];

	system("CLS");
	cout << "Here are the student supervision information of the school:\n";

	// TODO 5: group the students(in TA table)(student_ID, last_name, first_name) according to the supervisors' staff_IDs, and display the student information in a list,
	// see the screen shot for the exact output. Hint: you may find the LISTAGG() function and the concatenation operator are useful.
	// Add your code here

	strcpy_s(query, "SELECT p.staff_id, p.first_name || ',' || p.last_name AS staff_full_name, LISTAGG(t.student_id || ':' || t.first_name || ' ' || t.last_name, ',') AS students FROM prof p, supervise s, ta t WHERE p.staff_id = s.staff_id AND s.student_id = t.student_id GROUP BY p.staff_id, p.first_name, p.last_name;");
	SQLExecDirectA(hstmt, (SQLCHAR*)query, SQL_NTS);

	printIntoRow(hstmt, 20);

	SQLFreeStmt(hstmt, SQL_CLOSE);
	system("pause");

}

void adminInfo() {

	int command = 0;
	int ISdone = 0;

	while (!ISdone) {
		system("CLS");
		cout << "=================== Administrative Information ======================\n\n";
		cout << "0. Return to the previous menu                          (input '0').\n";
		cout << "1. Add a new phone                                      (input '1').\n";
		cout << "Please enter your choice: ";

		cin >> command;

		char buf[2];
		cin.getline(buf, 2); // grab the endline character when the user press "Enter"

		cout << endl;

		switch (command) {
		case 1:
			addPhone();
			ISdone = 0;
			break;

		case 0:
			ISdone = 1;
			break;
		default:
			break;
		}
	}
}

void addPhone() {
	int newPhone;
	char query[1000];

	cout << "\nPlease input the new phone number(limited to 8 digits ) you want to add: ";
	cin >> newPhone;
	// TODO 6:  add a new phone number for the prof. 
	// for the expect behaviour of this part please refer to the executable program
	// Add your code here
	int phone_number;
	SQLLEN cbphone_number = 0;

	sprintf_s(query, "SELECT phone_number FROM prof_phone WHERE staff_id = %d", staff_id);
	SQLExecDirectA(hstmt, (SQLCHAR*)query, SQL_NTS);
	SQLBindCol(hstmt, 1, SQL_INTEGER, &phone_number, 32, &cbphone_number);

	while (true) {
		ret = SQLFetch(hstmt);
		if (ret == SQL_SUCCESS || ret == SQL_SUCCESS_WITH_INFO) {
			if (newPhone == phone_number) {
				cout << "FAIL to add phone number" << endl;
				break;
			}
		}
		else {
			char insertion_query[1000];

			sprintf_s(insertion_query, "INSERT INTO prof_phone VALUES (%d, %d)", staff_id, newPhone);
			SQLExecDirectA(hstmt, (SQLCHAR*) insertion_query, SQL_NTS);

			cout << "SUCCESS in adding phone number" << endl;
			break;
		}
	}

	SQLFreeStmt(hstmt, SQL_CLOSE);
	system("pause");

}


boolean userLogin() {

	int loginOption;
	char username[20] = { 0 }, password[11] = { 0 };
	char query[1000] = { 0 };
	char inputUsername[20];
	string inputPassword;
	SQLLEN cbUsername = 0, cbPassword = 0;


	boolean success = false;

	while (!success) {
		system("CLS"); // Clear the screen
		cout << "===Welcome to Information System of the University of ST===\n\n";
		cout << "Please choose one of the follow options:\n";
		cout << "0. to terminate the program                      (input '0').\n";
		cout << "1. Log in as a professor                         (input '1').\n";
		cout << "Please enter your choice: ";
		cin >> loginOption;

		char buf[2];
		cin.getline(buf, 2); // grab the endline character when the user press "Enter"

		// Exit if the user keys in "0"
		if (loginOption == 0)
			break;

		if (loginOption == 1) {

			cout << "Please enter your username: ";
			cin >> inputUsername;

			// Exit if the user keys in "0"
			//if (strcmp(inputUsername,"0") == 0)
			//	break;

			cout << "Please enter your Password: ";
			inputPassword = "";

			// Get the input character by character and mask the password
			boolean flag = true;
			while (flag)
			{
				char chr = getch();
				if (chr == '\r') flag = false;

				else { cout << '*'; inputPassword += chr; }
			}

			cin.clear();
			cin.ignore(256, '\n');
			cout << endl;

			// This part has been Done for you.
			// Check whether the user is a valid user. This is done through checking inputUsername and password and see whether
			// they match with prof.user_name and prof.password. The user_name and password are new added attributes, please
			// refer to the 'insert_record.sql' for the exact values. Note that we are using SQLExecDirectA(), and we copy the
			// returned values from the Oracle server using the SQLBindCol() function. We then SQLFetch() to retrieve the results
			//(the columns: user_name,password,staff_id) from Oralce and copy them to the local variables username,password,
			//staff_id.

			SQLAllocStmt(hdbc, &hstmt);
			sprintf_s(query, "select user_name, password, staff_id from prof where user_name=\'%s\'", inputUsername);
			SQLExecDirectA(hstmt, (SQLCHAR*)query, SQL_NTS);
			SQLBindCol(hstmt, 1, SQL_C_CHAR, username, 20, &cbUsername);
			SQLBindCol(hstmt, 2, SQL_C_CHAR, password, 11, &cbPassword);
			SQLBindCol(hstmt, 3, SQL_INTEGER, &staff_id, 1, &cbStaffId);
			ret = SQLFetch(hstmt);

			if (ret == SQL_SUCCESS || ret == SQL_SUCCESS_WITH_INFO) {
				if (strcmp(inputPassword.c_str(), password) != 0) {
					cout << "Password Incorrect, please try again.\n";
					success = false;
					system("pause");
					system("CLS");

				}
				else {
					success = true;
				}
			}
			else {
				cout << "User does not exist, please try again.\n";
				success = false;
				system("pause");
				system("CLS");

			}
			SQLFreeStmt(hstmt, SQL_CLOSE);
			cout << endl;
		}
	}

	return success;
}

boolean ConnectDB() {
	RETCODE        ret;
	/* Allocate environment handle */
	ret = SQLAllocEnv(&henv);
	/* Allocate connection handle */
	ret = SQLAllocConnect(henv, &hdbc);
	/* Connect to the service */

	char oracleAccountName[20];
	string inputPassword;

	cout << "========Information System DB manager logon page=========\n\n";

	cout << "Please enter your Oracle account username: ";
	cin >> oracleAccountName;
	cout << "Please enter your Oracle account Password: ";
	inputPassword = "";

	// Mask the password
	boolean flag = true;
	while (flag) {
		char chr = getch();
		if (chr == '\r') flag = false;

		else { cout << '*'; inputPassword += chr; }
	}
	cout << endl;

	ret = SQLConnectA(hdbc, (SQLCHAR*)"comp3311.cse.ust.hk", SQL_NTS, (SQLCHAR*)oracleAccountName, SQL_NTS, (SQLCHAR*)inputPassword.c_str(), SQL_NTS);
	system("CLS"); // clear the screen
	if (ret == SQL_SUCCESS || ret == SQL_SUCCESS_WITH_INFO)
		return TRUE;
	return FALSE;
}

void DisconnectDB() {
	SQLDisconnect(hdbc);
	SQLFreeConnect(hdbc);
	SQLFreeEnv(henv);
}

// A generic function prints each row of return value into a column of information
void printRecordIntoCol(HSTMT stmt) {
	SQLCHAR columnName[10][64];
	SQLSMALLINT  noOfcolumns, columNameLength[10], dataType[10], decimalDigits[10], nullable[10];
	SQLULEN columnSize[10];
	SQLCHAR buf[10][64];
	SQLLEN indicator[10];

	// Find the total number of columns
	SQLNumResultCols(stmt, &noOfcolumns);

	for (int i = 0; i < noOfcolumns; i++) {
		// Retrieve the column metadata
		ret = SQLDescribeColA(hstmt, i + 1, columnName[i], sizeof(columnName[i]), &columNameLength[i], &dataType[i], &columnSize[i], &decimalDigits[i], &nullable[i]);
		// Bind the column result
		SQLBindCol(stmt, i + 1, SQL_C_CHAR, buf[i], sizeof(buf[i]), &indicator[i]);
	}

	// Print out the query result
	while (SQL_SUCCEEDED(SQLFetch(stmt))) {
		for (int i = 0; i < noOfcolumns; i++) {
			cout << setw(15) << left << columnName[i] << ": " << buf[i] << endl;
		}
		//cout<<endl;
	}
}

// A generic function prints out the query result by column with a maximum column width
SQLCHAR*** printIntoRow(HSTMT stmt, int maxColumnWidth) {
	SQLCHAR columnName[10][64];
	SQLSMALLINT  noOfcolumns, columNameLength[10], dataType[10], decimalDigits[10], nullable[10];
	SQLULEN columnSize[10];
	SQLCHAR buf[10][64];
	SQLCHAR*** result;
	SQLLEN indicator[10];

	// Find the total number of columns
	SQLNumResultCols(stmt, &noOfcolumns);


	for (int i = 0; i < maxColumnWidth * noOfcolumns; i++)
		cout << "-";
	cout << endl;

	// Initialize the result pointer
	result = new SQLCHAR * *[200];
	for (int i = 0; i < 100; i++) {
		result[i] = new SQLCHAR * [10];
		for (int j = 0; j < noOfcolumns; j++) {
			result[i][j] = new SQLCHAR[64];
		}
	}

	for (int i = 0; i < noOfcolumns; i++) {
		// Retreive the column metadata
		ret = SQLDescribeColA(hstmt, i + 1, columnName[i], sizeof(columnName[i]), &columNameLength[i], &dataType[i], &columnSize[i], &decimalDigits[i], &nullable[i]);

		// Bind the column result
		SQLBindCol(stmt, i + 1, SQL_C_CHAR, buf[i], sizeof(buf[i]), &indicator[i]);
	}

	int totalLength = 0;
	// Print out the column name
	for (int i = 0; i < noOfcolumns; i++) {
		if (columnSize[i] < columNameLength[i]) {
			cout << setw(columNameLength[i] + 2) << left << columnName[i];
			totalLength += columNameLength[i] + 2;
		}
		else if (columnSize[i] < maxColumnWidth) {
			cout << setw(columnSize[i] + 2) << left << columnName[i];
			totalLength += columnSize[i] + 2;
		}
		else {
			cout << setw(maxColumnWidth) << left << columnName[i];
			totalLength += maxColumnWidth;
		}
	}
	cout << endl;

	// Print out separate line
	for (int i = 0; i < maxColumnWidth * noOfcolumns; i++)
		cout << "-";
	cout << endl;

	// Print out the query result row by row
	int j = 0;
	while (SQL_SUCCEEDED(SQLFetch(stmt))) {
		for (int i = 0; i < noOfcolumns; i++) {
			// deep copy
			for (int k = 0; k < sizeof(buf[i]); k++) {
				result[j][i][k] = buf[i][k];
			}
			if (columnSize[i] < columNameLength[i]) {
				cout << setw(columNameLength[i] + 2) << left << buf[i];
			}
			else if (columnSize[i] < maxColumnWidth) {
				cout << setw(columnSize[i] + 2) << left << buf[i];
			}
			else {
				cout << setw(maxColumnWidth) << left << buf[i];
			}
		}
		j++;
		cout << endl;
	}

	return result;
}
