BEGIN EXECUTE IMMEDIATE 'DROP TABLE PA_RESULT CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE PA_SATELLITEN CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE PA_STERNE CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE PA_REFERENZ CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE PA_REFERENZ (
    EntscheidungID  INTEGER      PRIMARY KEY,
    Entscheidung    VARCHAR2(50) NOT NULL
);

CREATE TABLE PA_STERNE (
    Stern   VARCHAR2(50) PRIMARY KEY,
    Masse   NUMBER       NOT NULL,
    Radius  NUMBER       NOT NULL
);

CREATE TABLE PA_SATELLITEN (
    Kennung         VARCHAR2(50) PRIMARY KEY,
    Geschwindigkeit NUMBER       NOT NULL
);

CREATE TABLE PA_RESULT (
    Stern          VARCHAR2(50) NOT NULL,
    Kennung        VARCHAR2(50) NOT NULL,
    EntscheidungID INTEGER      NOT NULL,
    CONSTRAINT pk_result PRIMARY KEY (Stern, Kennung),
    CONSTRAINT fk_result_stern FOREIGN KEY (Stern)
        REFERENCES PA_STERNE (Stern),
    CONSTRAINT fk_result_sat FOREIGN KEY (Kennung)
        REFERENCES PA_SATELLITEN (Kennung),
    CONSTRAINT fk_result_ref FOREIGN KEY (EntscheidungID)
        REFERENCES PA_REFERENZ (EntscheidungID)
);

COMMIT;

INSERT ALL
    INTO PA_REFERENZ (EntscheidungID, Entscheidung) VALUES (0, 'Kreisen')
    INTO PA_REFERENZ (EntscheidungID, Entscheidung) VALUES (1, 'Kollidieren')
    INTO PA_REFERENZ (EntscheidungID, Entscheidung) VALUES (2, 'Weiter fliegen')
    INTO PA_REFERENZ (EntscheidungID, Entscheidung) VALUES (9, 'Entscheidungsfehler')
SELECT 1 FROM dual;

INSERT ALL
    INTO PA_STERNE (Stern, Masse, Radius) VALUES ('Aldebaran',  3.38E+30, 3.07E+10)
    INTO PA_STERNE (Stern, Masse, Radius) VALUES ('Arktur',     2.19E+30, 1.77E+10)
    INTO PA_STERNE (Stern, Masse, Radius) VALUES ('Betelgeuse', 3.28E+31, 6.17E+11)
    INTO PA_STERNE (Stern, Masse, Radius) VALUES ('Orion',      6.20E+35, 1.67E+13)
    INTO PA_STERNE (Stern, Masse, Radius) VALUES ('Polarstern', 8.70E+30, 7.78E+08)
    INTO PA_STERNE (Stern, Masse, Radius) VALUES ('Sonne',      1.99E+30, 6.96E+08)
    INTO PA_STERNE (Stern, Masse, Radius) VALUES ('Erde',       5.97E+24, 6.37E+06)
SELECT 1 FROM dual;

INSERT ALL
    INTO PA_SATELLITEN (Kennung, Geschwindigkeit) VALUES ('Bohr',       9.90E+04)
    INTO PA_SATELLITEN (Kennung, Geschwindigkeit) VALUES ('Galileo',    5.00E+05)
    INTO PA_SATELLITEN (Kennung, Geschwindigkeit) VALUES ('Higgs',      1.28E+14)
    INTO PA_SATELLITEN (Kennung, Geschwindigkeit) VALUES ('Kopernikus', 1.31E+08)
    INTO PA_SATELLITEN (Kennung, Geschwindigkeit) VALUES ('Newton',     9.10E+03)
    INTO PA_SATELLITEN (Kennung, Geschwindigkeit) VALUES ('Plank',      7.77E+78)
SELECT 1 FROM dual;

COMMIT;
