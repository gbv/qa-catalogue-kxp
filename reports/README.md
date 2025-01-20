Dieses Verzeichnis enthält **mittels QA Catalogue ermittelte Fehlerlisten von K10plus-Abzügen**. Jede Fehlerlisten ist in jeweils drei Formaten mit unterschiedlicher Dateieindung verfügbar:

- `.dat` [Normalisiertes PICA](https://format.gbv.de/pica/normalized) (eine Zeile pro Datensatz) beschränkt auf 003@ und das jeweilige Feld mit Fehler
- `.pp` [PICA Plain](https://format.gbv.de/pica/plain) die selben Datensätze
- `.ppn` PPN-Liste

Die Dateinamen ergeben sich aus dem jeweiligen Feld, wobei das Zeichen `/` für Occurrences durch `_` ersetzt wird. Beispiel: `045Q_02-99-unknown.ppn` für PPNs von Datensätzen mit unbekannten Feld `045Q/02-99`. Für unbekannte Untefelder wirdmit einem Punkt die Liste der Unterfelder angehängt z.B. `021A.L7xb-unknown.ppn` für die PPNs der Datensätze mit unbekanntem Unterfeld `021A$L`, `021A$7`, `021A$x` oder `021A$b`.

Eine Statistik der Datensätze mit unbekannten Feldern ist in der Datei `stats.csv`.
