CREATE OR REPLACE PACKAGE BODY SAT AS

    PROCEDURE GetVelocity(
        p_EKG    OUT NUMBER,
        p_ZKG    OUT NUMBER,
        p_Masse  IN  NUMBER,
        p_Radius IN  NUMBER
    ) IS
    BEGIN
        p_EKG := SQRT((C_GRAVITATIONSKONSTANTE * p_Masse) / p_Radius);
        p_ZKG := C_WURZEL_ZWEI * p_EKG;
    END GetVelocity;
    PROCEDURE Action IS
        v_EKG            NUMBER;
        v_ZKG           NUMBER;
        v_EntscheidungID INTEGER;

        CURSOR c_Sterne IS
            SELECT Stern, Masse, Radius
            FROM PA_STERNE;

        CURSOR c_Satelliten IS
            SELECT Kennung, Geschwindigkeit
            FROM PA_SATELLITEN;
    BEGIN
        FOR r_Stern IN c_Sterne LOOP
            FOR r_Satellit IN c_Satelliten LOOP
                GetVelocity(v_EKG, v_ZKG, r_Stern.Masse, r_Stern.Radius);

                IF r_Satellit.Geschwindigkeit < v_EKG THEN
                    v_EntscheidungID := 1;
                ELSIF r_Satellit.Geschwindigkeit <= v_ZKG THEN
                    v_EntscheidungID := 0;
                ELSIF r_Satellit.Geschwindigkeit > v_ZKG THEN
                    v_EntscheidungID := 2;
                ELSE
                    v_EntscheidungID := 9;
                END IF;

                INSERT INTO PA_RESULT (Stern, Kennung, EntscheidungID)
                VALUES (r_Stern.Stern, r_Satellit.Kennung, v_EntscheidungID);
            END LOOP;
        END LOOP;
    END Action;

END SAT;
/ 