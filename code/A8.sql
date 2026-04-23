DECLARE
    CURSOR c_Ergebnis IS
        SELECT r.Stern,
               r.Kennung,
               ref.Entscheidung
          FROM PA_RESULT r
          JOIN PA_REFERENZ ref
            ON r.EntscheidungID = ref.EntscheidungID
      ORDER BY r.Stern, r.Kennung;
BEGIN
    DELETE FROM PA_RESULT;

    SAT.Action;

    FOR r_Ergebnis IN c_Ergebnis LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Stern: ' || RPAD(r_Ergebnis.Stern, 12) ||
            ' | Satellit: ' || RPAD(r_Ergebnis.Kennung, 12) ||
            ' | Entscheidung: ' || r_Ergebnis.Entscheidung
        );
    END LOOP;
END;
/
COMMIT;