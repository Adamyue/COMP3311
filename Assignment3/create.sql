/* create tables */

drop table technician_table;
drop table technician_phone;
drop table controller_table;
drop table test;
drop table expert_of;
drop table done_by;
drop table plane;
drop table employee_table;
drop table model;

create table employee_table
(
    employee_ID number(8) primary key,
    union_mem# number(8)
);

create table technician_table
(
    employee_ID number(8) primary key,
    tech_name varchar2(80) not null,
    skill_level number(2) not null,
    salary number(7) not null,
    city varchar2(80),
    street varchar2(80),
    house# number(4),

    foreign key (employee_ID) references employee_table on delete cascade
);

create table technician_phone
(
    employee_ID number(8),
    phone# number(8),

    primary key(employee_ID, phone#),
    foreign key (employee_ID) references employee_table on delete cascade
);

create table controller_table
(
    employee_ID number(8) primary key,
    exam_date date,

    foreign key (employee_ID) references employee_table on delete cascade
);

create table model
(
    model# number(6) primary key,
    capacity number(4),
    weight number(5)
);

create table plane
(
    plane_reg# number(10),
    model# number(6),
    
    primary key (plane_reg#),
    foreign key (model#) references model on delete cascade
);

create table test
(
    test# varchar2(3),
    plane_reg# number(10),
    test_name varchar2(80) not null,
    score number(3) not null,

    primary key(test#, plane_reg#),
    foreign key (plane_reg#) references plane on delete cascade 
);

create table done_by
(
    test# varchar2(3),
    plane_reg# number(10),
    employee_ID number(8),
    hours number(3) not null,
    done_date date not null,

    primary key (test#, plane_reg#, employee_ID),
    -- not sure
    -- foreign key (test#) references test on delete cascade,
    foreign key (plane_reg#) references plane on delete cascade,
    foreign key (employee_ID) references employee_table on delete cascade
);

create table expert_of
(
    employee_ID number(8),
    model# number(6),

    primary key (employee_ID, model#),
    foreign key (employee_ID) references employee_table on delete cascade,
    foreign key (model#) references model on delete cascade
);

-- insert into employee_table values (12345678, 00000001);
-- insert into employee_table values (12345679, 00000002);
-- insert into employee_table values (23456789, 00000003);
-- insert into employee_table values (12345689, 00000004);
-- insert into employee_table values (13579246, 00000005);
-- insert into employee_table values (24680135, 00000006);
-- insert into employee_table values (00000001, 00000007);
-- insert into employee_table values (00000002, 00000008);
-- insert into employee_table values (00000003, 00000009);
-- insert into employee_table values (00000005, 00000010);


-- insert into technician_table values (12345678, 'Alice', 8, 4000, 'New York', 'New Street', 0001);
-- insert into technician_table values (12345679, 'Bob', 5, 2500, 'New York', 'New Street', 0003);
-- insert into technician_table values (23456789, 'Cindy', 6, 3000, 'Wu Han', 'B Street', 0004);
-- insert into technician_table values (12345689, 'David', 8, 4000, 'New York', 'New Street', 1000);
-- insert into technician_table values (13579246, 'Eve', 8, 4000, 'Hong Kong', 'A road', 0007);
-- insert into technician_table values (24680135, 'Fuck', 7, 3500, 'New York', 'Old Street', 0032);
-- insert into technician_table values (00000001, 'GG', 8, 4000, 'New York', 'Old Street', 0045);


-- insert into controller_table values (00000002, TO_DATE('2023/09/01', 'YYYY/MM/dd'));
-- insert into controller_table values (00000003, TO_DATE('2023/10/03', 'YYYY/MM/dd'));
-- insert into controller_table values (00000005, TO_DATE('2022/11/04', 'YYYY/MM/dd'));


-- insert into technician_phone values (12345678, 11111111);
-- insert into technician_phone values (12345679, 22222222);
-- insert into technician_phone values (12345678, 88888888);
-- insert into technician_phone values (23456789, 33333333);
-- insert into technician_phone values (12345689, 44444444);
-- insert into technician_phone values (13579246, 55555555);
-- insert into technician_phone values (24680135, 66666666);
-- insert into technician_phone values (00000001, 77777777);
-- insert into technician_phone values (00000001, 99999999);
-- insert into technician_phone values (00000001, 00000020);


-- insert into model values (000001, 1000, 10000);
-- insert into model values (000002, 2000, 20000);
-- insert into model values (000003, 3000, 30000);
-- insert into model values (000004, 4000, 40000);
-- insert into model values (000005, 5000, 50000);
-- insert into model values (000006, 6000, 60000);
-- insert into model values (000007, 7000, 70000);
-- insert into model values (000008, 8000, 80000);
-- insert into model values (000009, 9000, 90000);
-- insert into model values (000010, 1010, 10001);


-- insert into plane values (1,000001);
-- insert into plane values (2,000001);
-- insert into plane values (3,000001);
-- insert into plane values (4,000001);
-- insert into plane values (5,000001);
-- insert into plane values (6,000002);
-- insert into plane values (7,000002);
-- insert into plane values (8,000002);
-- insert into plane values (9,000002);
-- insert into plane values (10,000003);
-- insert into plane values (11,000003);
-- insert into plane values (12,000003);
-- insert into plane values (13,000003);
-- insert into plane values (14,000003);
-- insert into plane values (15,000003);
-- insert into plane values (16,000003);
-- insert into plane values (17,000004);
-- insert into plane values (18,000004);
-- insert into plane values (19,000005);
-- insert into plane values (20,000005);
-- insert into plane values (21,000005);
-- insert into plane values (22,000005);
-- insert into plane values (23,000006);
-- insert into plane values (24,000007);
-- insert into plane values (25,000007);
-- insert into plane values (26,000007);
-- insert into plane values (27,000007);
-- insert into plane values (28,000007);
-- insert into plane values (29,000007);
-- insert into plane values (30,000007);
-- insert into plane values (31,000007);
-- insert into plane values (32,000007);
-- insert into plane values (33,000008);
-- insert into plane values (34,000008);
-- insert into plane values (35,000008);
-- insert into plane values (36,000008);
-- insert into plane values (37,000008);
-- insert into plane values (38,000009);
-- insert into plane values (39,000009);
-- insert into plane values (40,000009);
-- insert into plane values (41,000009);
-- insert into plane values (42,000010);
-- insert into plane values (43,000010);
-- insert into plane values (44,000010);


-- insert into test values (1, 1, 'test1', 199);
-- insert into test values (2, 1, 'test2', 108);
-- insert into test values (3, 1, 'test3', 107);
-- insert into test values (4, 1, 'test4', 106);
-- insert into test values (5, 2, 'Controller System Test', 104);
-- insert into test values (6, 2, 'test6', 105);
-- insert into test values (7, 2, 'Controller System Test', 103);
-- insert into test values (8, 3, 'test8', 99);
-- insert into test values (10, 3, 'test9', 56);
-- insert into test values (11, 4, 'Controller System Test', 67);
-- insert into test values (12, 4, 'test11', 56);
-- insert into test values (13, 4, 'Controller System Test', 345);
-- insert into test values (14, 4, 'test13', 34);
-- insert into test values (15, 5, 'Controller System Test', 67);
-- insert into test values (16, 5, 'test16', 88);
-- insert into test values (17, 6, 'Controller System Test', 99);
-- insert into test values (18, 7, 'test18', 565);
-- insert into test values (19, 8, 'test19', 888);
-- insert into test values (20, 9, 'test20', 342);
-- insert into test values (21, 9, 'test21', 99);
-- insert into test values (22, 10, 'Controller System Test',123);
-- insert into test values (23, 10, 'test23', 333);
-- insert into test values (24, 11, 'Controller System Test', 44);
-- insert into test values (25, 12, 'test25', 66);
-- insert into test values (26, 13, 'test26', 99);
-- insert into test values (27, 14, 'test27', 234);
-- insert into test values (28, 15, 'test28', 666);
-- insert into test values (29, 16, 'Controller System Test', 777);
-- insert into test values (30, 17, 'test30', 444);
-- insert into test values (31, 17, 'test31', 789);
-- insert into test values (32, 17, 'Controller System Test', 34);
-- insert into test values (33, 18, 'test33', 10);
-- insert into test values (34, 19, 'Controller System Test', 40);
-- insert into test values (35, 20, 'Controller System Test', 50);
-- insert into test values (36, 21, 'test36', 60);
-- insert into test values (37, 21, 'test37', 70);
-- insert into test values (38, 22, 'test38', 156);
-- insert into test values (39, 23, 'test39', 145);
-- insert into test values (40, 24, 'test40', 14);
-- insert into test values (41, 25, 'test41', 80);
-- insert into test values (42, 26, 'test42', 30);
-- insert into test values (43, 27, 'test43', 60);
-- insert into test values (44, 27, 'test44', 40);
-- insert into test values (45, 27, 'Controller System Test', 800);
-- insert into test values (46, 28, 'test46', 100);
-- insert into test values (47, 29, 'test47', 70);
-- insert into test values (48, 30, 'test48', 660);
-- insert into test values (49, 31, 'Controller System Test', 70);
-- insert into test values (50, 32, 'test50', 780);
-- insert into test values (51, 32, 'test51', 80);
-- insert into test values (52, 32, 'test52', 90);
-- insert into test values (53, 32, 'test53', 450);
-- insert into test values (54, 33, 'Controller System Test', 60);
-- insert into test values (55, 34, 'Controller System Test', 90);
-- insert into test values (56, 35, 'Controller System Test', 110);
-- insert into test values (57, 36, 'Controller System Test', 100);
-- insert into test values (58, 36, 'test58', 100);
-- insert into test values (59, 37, 'Controller System Test', 150);
-- insert into test values (60, 38, 'test60', 160);
-- insert into test values (61, 38, 'test61', 107);
-- insert into test values (62, 39, 'Controller System Test', 109);
-- insert into test values (63, 39, 'test63', 134);
-- insert into test values (64, 39, 'Controller System Test', 156);
-- insert into test values (65, 40, 'test65', 158);
-- insert into test values (66, 41, 'test66', 146);
-- insert into test values (67, 42, 'Controller System Test', 178);
-- insert into test values (68, 42, 'Controller System Test', 345);
-- insert into test values (69, 43, 'test69', 236);
-- insert into test values (70, 44, 'test70', 285);


-- insert into expert_of values (12345678, 000001);
-- insert into expert_of values (12345678, 000007);
-- insert into expert_of values (12345678, 000008);
-- insert into expert_of values (12345679, 000002);
-- insert into expert_of values (12345679, 000003);
-- insert into expert_of values (12345679, 000005);
-- insert into expert_of values (23456789, 000002);
-- insert into expert_of values (23456789, 000006);
-- insert into expert_of values (23456789, 000008);
-- insert into expert_of values (12345689, 000004);
-- insert into expert_of values (12345689, 000009);
-- insert into expert_of values (12345689, 000010);
-- insert into expert_of values (13579246, 000001);
-- insert into expert_of values (24680135, 000007);
-- insert into expert_of values (00000001, 000004);
-- insert into expert_of values (00000001, 000008);


-- insert into done_by values (1, 1, 12345678, 1, TO_DATE('2023/09/01','YYYY/MM/DD'));
-- insert into done_by values (2, 1, 12345678, 1, TO_DATE('2023/09/02','YYYY/MM/DD'));
-- insert into done_by values (3, 1, 12345678, 1, TO_DATE('2023/09/02','YYYY/MM/DD'));
-- insert into done_by values (4, 1, 12345678, 1, TO_DATE('2023/09/03','YYYY/MM/DD'));
-- insert into done_by values (5, 2, 13579246, 1, TO_DATE('2023/10/04','YYYY/MM/DD'));
-- insert into done_by values (6, 2, 13579246, 1, TO_DATE('2023/09/04','YYYY/MM/DD'));
-- insert into done_by values (6, 2, 12345678, 1, TO_DATE('2023/09/04','YYYY/MM/DD'));
-- insert into done_by values (7, 2, 13579246, 1, TO_DATE('2023/09/05','YYYY/MM/DD'));
-- insert into done_by values (8, 3, 12345678, 1, TO_DATE('2023/09/06','YYYY/MM/DD'));
-- insert into done_by values (10, 3, 12345678, 1, TO_DATE('2023/09/06','YYYY/MM/DD'));
-- insert into done_by values (11, 4, 12345678, 1, TO_DATE('2023/09/06','YYYY/MM/DD'));
-- insert into done_by values (12, 4, 12345678, 1, TO_DATE('2023/09/07','YYYY/MM/DD'));
-- insert into done_by values (12, 4, 13579246, 1, TO_DATE('2023/09/07','YYYY/MM/DD'));
-- insert into done_by values (13, 4, 12345678, 1, TO_DATE('2023/09/08','YYYY/MM/DD'));
-- insert into done_by values (14, 4, 12345678, 1, TO_DATE('2023/09/08','YYYY/MM/DD'));
-- insert into done_by values (14, 4, 13579346, 1, TO_DATE('2023/09/08','YYYY/MM/DD'));
-- insert into done_by values (15, 5, 12345678, 1, TO_DATE('2023/10/13','YYYY/MM/DD'));
-- insert into done_by values (16, 5, 12345678, 1, TO_DATE('2023/10/15','YYYY/MM/DD'));

-- insert into done_by values (17, 6, 12345679, 1, TO_DATE('2023/09/16','YYYY/MM/DD'));
-- insert into done_by values (18, 7, 23456789, 1, TO_DATE('2023/09/17','YYYY/MM/DD'));
-- insert into done_by values (19, 8, 12345679, 1, TO_DATE('2023/09/18','YYYY/MM/DD'));
-- insert into done_by values (20, 9, 12345679, 1, TO_DATE('2023/09/20','YYYY/MM/DD'));
-- insert into done_by values (20, 9, 23456789, 1, TO_DATE('2023/09/20','YYYY/MM/DD'));
-- insert into done_by values (21, 9, 12345679, 1, TO_DATE('2023/09/21','YYYY/MM/DD'));

-- insert into done_by values (22, 10, 12345679, 1, TO_DATE('2023/10/03','YYYY/MM/DD'));
-- insert into done_by values (23, 10, 12345679, 1, TO_DATE('2023/11/01','YYYY/MM/DD'));
-- insert into done_by values (24, 11, 12345679, 1, TO_DATE('2023/09/15','YYYY/MM/DD'));
-- insert into done_by values (25, 12, 12345679, 1, TO_DATE('2023/11/02','YYYY/MM/DD'));
-- insert into done_by values (26, 13, 12345679, 1, TO_DATE('2023/10/06','YYYY/MM/DD'));
-- insert into done_by values (27, 14, 12345679, 1, TO_DATE('2023/08/01','YYYY/MM/DD'));
-- insert into done_by values (28, 15, 12345679, 1, TO_DATE('2023/04/05','YYYY/MM/DD'));
-- insert into done_by values (29, 16, 12345679, 1, TO_DATE('2023/09/24','YYYY/MM/DD'));

-- insert into done_by values (30, 17, 12345679, 1, TO_DATE('2023/01/01','YYYY/MM/DD'));
-- insert into done_by values (31, 17, 00000001, 1, TO_DATE('2024/09/01','YYYY/MM/DD'));
-- insert into done_by values (32, 17, 12345679, 1, TO_DATE('2024/09/14','YYYY/MM/DD'));
-- insert into done_by values (32, 17, 00000001, 1, TO_DATE('2023/03/05','YYYY/MM/DD'));
-- insert into done_by values (33, 18, 00000001, 1, TO_DATE('2023/05/16','YYYY/MM/DD'));

-- insert into done_by values (34, 19, 12345679, 1, TO_DATE('2023/10/08','YYYY/MM/DD'));
-- insert into done_by values (35, 20, 12345679, 1, TO_DATE('2023/11/01','YYYY/MM/DD'));
-- insert into done_by values (36, 21, 12345679, 1, TO_DATE('2023/11/01','YYYY/MM/DD'));
-- insert into done_by values (37, 21, 12345679, 1, TO_DATE('2024/10/22','YYYY/MM/DD'));
-- insert into done_by values (38, 22, 12345679, 1, TO_DATE('2022/10/22','YYYY/MM/DD'));

-- insert into done_by values (39, 23, 23456789, 1, TO_DATE('2023/09/29','YYYY/MM/DD'));

-- insert into done_by values (40, 24, 12345678, 1, TO_DATE('2023/10/02','YYYY/MM/DD'));
-- insert into done_by values (41, 25, 12345678, 1, TO_DATE('2023/09/01','YYYY/MM/DD'));
-- insert into done_by values (42, 26, 12345678, 1, TO_DATE('2023/09/11','YYYY/MM/DD'));
-- insert into done_by values (43, 27, 12345678, 1, TO_DATE('2023/09/21','YYYY/MM/DD'));
-- insert into done_by values (44, 27, 12345678, 1, TO_DATE('2023/09/24','YYYY/MM/DD'));
-- insert into done_by values (45, 27, 12345678, 1, TO_DATE('2023/06/22','YYYY/MM/DD'));
-- insert into done_by values (45, 27, 24680135, 1, TO_DATE('2023/07/01','YYYY/MM/DD'));
-- insert into done_by values (46, 28, 12345678, 1, TO_DATE('2023/08/01','YYYY/MM/DD'));
-- insert into done_by values (46, 28, 24680135, 1, TO_DATE('2023/02/21','YYYY/MM/DD'));
-- insert into done_by values (47, 29, 12345678, 1, TO_DATE('2023/09/16','YYYY/MM/DD'));
-- insert into done_by values (48, 30, 12345678, 1, TO_DATE('2024/09/01','YYYY/MM/DD'));
-- insert into done_by values (49, 31, 12345678, 1, TO_DATE('2024/10/30','YYYY/MM/DD'));
-- insert into done_by values (50, 32, 12345678, 1, TO_DATE('2022/10/24','YYYY/MM/DD'));
-- insert into done_by values (50, 32, 24680135, 1, TO_DATE('2023/09/15','YYYY/MM/DD'));
-- insert into done_by values (51, 32, 12345678, 1, TO_DATE('2023/09/16','YYYY/MM/DD'));
-- insert into done_by values (52, 32, 12345678, 1, TO_DATE('2023/05/25','YYYY/MM/DD'));
-- insert into done_by values (53, 32, 12345678, 1, TO_DATE('2023/04/26','YYYY/MM/DD'));

-- insert into done_by values (54, 33, 12345678, 1, TO_DATE('2021/05/21','YYYY/MM/DD'));
-- insert into done_by values (54, 33, 23456789, 1, TO_DATE('2022/09/01','YYYY/MM/DD'));
-- insert into done_by values (55, 34, 12345678, 1, TO_DATE('2022/07/17','YYYY/MM/DD'));
-- insert into done_by values (56, 35, 12345678, 1, TO_DATE('2023/09/01','YYYY/MM/DD'));
-- insert into done_by values (57, 36, 12345678, 1, TO_DATE('2023/09/27','YYYY/MM/DD'));
-- insert into done_by values (57, 36, 23456789, 1, TO_DATE('2023/09/28','YYYY/MM/DD'));
-- insert into done_by values (58, 36, 23456789, 1, TO_DATE('2024/04/01','YYYY/MM/DD'));
-- insert into done_by values (59, 37, 12345678, 1, TO_DATE('2023/09/19','YYYY/MM/DD'));
-- insert into done_by values (59, 37, 23456789, 1, TO_DATE('2023/09/19','YYYY/MM/DD'));
-- insert into done_by values (59, 37, 00000001, 1, TO_DATE('2023/09/19','YYYY/MM/DD'));

-- insert into done_by values (60, 38, 12345689, 1, TO_DATE('2025/10/18','YYYY/MM/DD'));
-- insert into done_by values (61, 38, 12345689, 1, TO_DATE('2023/09/01','YYYY/MM/DD'));
-- insert into done_by values (62, 39, 12345689, 1, TO_DATE('2024/04/15','YYYY/MM/DD'));
-- insert into done_by values (63, 39, 12345689, 1, TO_DATE('2023/11/16','YYYY/MM/DD'));
-- insert into done_by values (64, 39, 12345689, 1, TO_DATE('2023/11/08','YYYY/MM/DD'));
-- insert into done_by values (65, 40, 12345689, 1, TO_DATE('2023/09/07','YYYY/MM/DD'));
-- insert into done_by values (66, 41, 12345689, 1, TO_DATE('2022/06/21','YYYY/MM/DD'));

-- insert into done_by values (67, 42, 12345689, 1, TO_DATE('2023/07/08','YYYY/MM/DD'));
-- insert into done_by values (68, 42, 12345689, 1, TO_DATE('2023/03/09','YYYY/MM/DD'));
-- insert into done_by values (69, 43, 12345689, 1, TO_DATE('2023/09/16','YYYY/MM/DD'));
-- insert into done_by values (70, 44, 12345689, 1, TO_DATE('2023/10/23','YYYY/MM/DD'));