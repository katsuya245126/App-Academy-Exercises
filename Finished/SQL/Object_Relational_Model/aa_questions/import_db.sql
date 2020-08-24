PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id    INTEGER PRIMARY KEY,
    fname TEXT    NOT NULL,
    lname TEXT    NOT NULL
);

CREATE TABLE questions (
    id      INTEGER PRIMARY KEY,
    title   TEXT    NOT NULL,
    body    TEXT    NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id          INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id     INTEGER NOT NULL,
    
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id)     REFERENCES users(id)
);

CREATE TABLE replies (
    id          INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    reply_id  INTEGER,
    user_id     INTEGER NOT NULL,
    body        TEXT    NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (reply_id)  REFERENCES replies(id),
    FOREIGN KEY (user_id)     REFERENCES users(id)
);

CREATE TABLE question_likes (
    id          INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id     INTEGER NOT NULL,

    FOREIGN KEY (question_id)  REFERENCES questions(id),
    FOREIGN KEY (user_id)      REFERENCES users(id)
);

INSERT INTO users (fname, lname)
VALUES ("John", "Miller"),
       ("Adam", "Smith"),
       ("Billy", "Beta"),
       ("Donald", "Trump"),
       ("Chad", "Thundercock");

INSERT INTO questions (title, body, user_id)
VALUES ("How to restore computer?", "I deleted system32 accidentally", 1),
       ("How do I install google ultron?", "I want nasa approved chrome", 2),
       ("How do I download more ram?", "i want play games very good", 3),
       ("How do I hack facebook?", "I want to be leet haxor", 4),
       ("Why am I so chad?", "How can one be so alpha", 5);

INSERT INTO question_follows (question_id, user_id)
VALUES (1, 2),
       (1, 3),
       (2, 1),
       (2, 3),
       (2, 4),
       (4, 1),
       (4, 2),
       (4, 3),
       (4, 5),
       (5, 4);

INSERT INTO replies (question_id, reply_id, user_id, body)
VALUES (1, NULL, 2, "You gotta buy a new one"),
       (1, 1, 1, "Man that sucks!"),
       (2, NULL, 4, "You have to be IT guy"),
       (4, NULL, 5, "You have to give me your username and password"),
       (4, 4, 3, "sure man it's admin and hunter2"),
       (4, 5, 5, "Thanks :)"),
       (5, NULL, 5, "Why yes I am");

INSERT INTO question_likes (question_id, user_id)
VALUES (1, 2),
       (1, 3),
       (2, 1),
       (2, 3),
       (2, 4),
       (4, 1),
       (4, 3),
       (5, 1),
       (5, 2),
       (5, 3),
       (5, 5),
       (5, 4);