--a)
SELECT telefon FROM ksiegowosc.pracownicy;

UPDATE ksiegowosc.pracownicy
SET telefon = '(+48)' + telefon
WHERE telefon IS NOT NULL

--b)
UPDATE ksiegowosc.pracownicy
SET telefon = REPLACE (telefon, ' ', '-')
WHERE telefon IS NOT NULL

--c)
SELECT id_pracownika,
UPPER(imie) AS IMIE, 
UPPER(nazwisko) AS NAZWISKO, 
UPPER(adres) AS ADRES, 
telefon FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy )

--d)
SELECT prac.id_pracownika,
imie = CONVERT(NVARCHAR(30), HASHBYTES('MD5', CONVERT(NVARCHAR, prac.imie)), 2),
nazwisko = CONVERT(NVARCHAR(30), HASHBYTES('MD5', CONVERT(NVARCHAR, prac.nazwisko)), 2),
adres = CONVERT(NVARCHAR(50), HASHBYTES('MD5', CONVERT(NVARCHAR, prac.adres)), 2),
telefon = CONVERT(VARCHAR(20), HASHBYTES('MD5', CONVERT(VARCHAR, prac.telefon)), 2),
pen.kwota
FROM ksiegowosc.pracownicy prac
INNER JOIN ksiegowosc.wynagrodzenia w
ON w.id_pracownika = prac.id_pracownika
INNER JOIN ksiegowosc.pensja pen
ON w.id_pensji = pen.id_pensji

--e) (f)
SELECT w.id_wynagrodzenia, pra.imie, pra.nazwisko, pen.kwota AS pensja, pre.kwota AS premia FROM ksiegowosc.pracownicy pra 
LEFT OUTER JOIN ksiegowosc.wynagrodzenia w ON w.id_pracownika = pra.id_pracownika
LEFT OUTER JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
LEFT OUTER JOIN ksiegowosc.premia pre ON w.id_premii = pre.id_premii
GROUP BY w.id_wynagrodzenia, pra.imie, pra.nazwisko, pen.kwota, pre.kwota --¿eby wyeliminowaæ powtarzanie siê wartoœci

--f) (g)
ALTER TABLE ksiegowosc.godziny
ADD liczba_nadgodzin INT

UPDATE ksiegowosc.godziny SET liczba_nadgodzin = (liczba_godzin * 21 -160)
WHERE (liczba_godzin * 21 - 160) > 0

UPDATE ksiegowosc.godziny SET liczba_nadgodzin = 0
WHERE liczba_nadgodzin IS NULL

SELECT
	CONCAT('Pracownik ', pra.imie, ' ', pra. nazwisko, 
	' w dniu ', g.data, 
	' otrzyma³ pensjê ca³kowit¹ na kwotê ', 
	CAST(pen.kwota + ISNULL(pre.kwota, 0) + (1.5 * (pen.kwota/21) * g.liczba_nadgodzin) AS decimal(10,2)), 
	' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', pen.kwota, 
	' z³, premia: ', ISNULL(pre.kwota, 0), 
	' z³, nadgodziny: ', CAST( 1.5*(pen.kwota/21) * g.liczba_nadgodzin AS decimal(10,2)), ' z³') AS 'Raport'
FROM ksiegowosc.pracownicy pra 
	LEFT  JOIN ksiegowosc.wynagrodzenia w ON w.id_pracownika = pra.id_pracownika
	LEFT  JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
	LEFT  JOIN ksiegowosc.premia pre ON w.id_premii = pre.id_premii
	LEFT  JOIN ksiegowosc.godziny g ON w.id_godziny = g.id_godziny;