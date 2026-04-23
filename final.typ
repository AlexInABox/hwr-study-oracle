#set text(lang: "de")
#set text(font: "Berlin Type Office")
#set page(
  paper: "a4",
  header: [
    #grid(
      columns: (1fr, auto),
      column-gutter: 1cm,
      align: (left, top),
      [
        #text(size: 9pt, fill: black, weight: "bold")[
          #set par(leading: 0.45em) //looks nice if they are hugging
          Alexander Betke \
          77203378972 \
          #datetime.today().display("[day].[month].[year]")† \
        ]
      ],
      [#image("assets/hwr_logo.svg", height: 1.2cm)],
    )
  ],
  numbering: "1",
)

== Aufgabe 1:
ERM in Peter-Chen-Notation
#image("assets/ERM.pdf", width: 100%)

== Aufgabe 2:
ERM als Tabellen

// Responsive grid
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,

  figure(caption: [*PA_STERNE*], table(
    columns: 3,
    [*#underline[Stern]*], [*Masse*], [*Radius*],

    [Aldebaran], [3.38e30], [3.07e10],
    [Arktur], [2.19e30], [1.77e10],
    [Betelgeuse], [3.28e31], [6.17e11],
    [Orion], [6.20e35], [1.67e13],
    [Polarstern], [8.70e30], [7.78e08],
    [Sonne], [1.99e30], [6.96e08],
    [Erde], [5.97e24], [6.37e06],
  )),

  figure(caption: [*PA_SATELLITEN*], table(
    columns: 2,
    [*#underline[Kennung]*], [*Geschwindigkeit*],

    [Bohr], [9.90e04],
    [Galileo], [5.00e05],
    [Higgs], [1.28e14],
    [Kopernikus], [1.31e08],
    [Newton], [9.10e03],
    [Plank], [7.77e78],
  )),

  figure(caption: [*PA_REFERENZ*], table(
    columns: 2,
    [*#underline[EntscheidungsID]*], [*Entscheidung*],

    [0], [Kreisen],
    [1], [Kollidieren],
    [2], [Weiter fliegen],
    [9], [Entscheidungsfehler],
  )),

  figure(caption: [*PA_RESULT*], table(
    columns: 3,
    [*#underline[Stern]*], [*#underline[Kennung]*], [*EntscheidungsID*],

    [Orion], [Plank], [2],
    [...], [...], [...],
  )),
)

#pagebreak()

== Aufgabe 3:
Normalformen der Tabellen

=== PA_STERNE
Die Tabelle *PA_STERNE* hat den Primärschlüssel *Stern* und die Attribute *Masse* sowie *Radius*. Da alle Werte atomar vorliegen, ist die 1NF erfüllt, und wegen des einattributigen Schlüssels ist auch die 2NF unmittelbar gegeben.

*Masse* und *Radius* werden jeweils direkt durch *Stern* bestimmt; eine transitive Abhängigkeit liegt nicht vor, weil die Nichtschlüsselattribute einander nicht funktional bestimmen. Damit befindet sich *PA_STERNE* in der dritten Normalform.

=== PA_SATELLITEN
Für *PA_SATELLITEN* mit *Kennung* als Primärschlüssel und *Geschwindigkeit* als einzigem Nichtschlüsselattribut gilt dieselbe Logik. Die Attributwerte sind atomar (1NF), und partielle Abhängigkeiten sind durch den einteiligen Schlüssel ausgeschlossen (2NF).

Da *Geschwindigkeit* ausschließlich von *Kennung* abhängt und kein weiteres Nichtschlüsselattribut vorhanden ist, kann keine transitive Abhängigkeit entstehen. Die Tabelle erfüllt somit die 3NF.

=== PA_REFERENZ
Die Tabelle *PA_REFERENZ* besteht aus dem Primärschlüssel *EntscheidungsID* und dem Attribut *Entscheidung*. Auch hier sind die Werte atomar und wegen des einattributigen Schlüssels treten keine partiellen Abhängigkeiten auf.

*Entscheidung* hängt direkt von *EntscheidungsID* ab, und ein transitiver Pfad ist mangels weiterer Nichtschlüsselattribute nicht möglich. Daher liegt *PA_REFERENZ* ebenfalls in der dritten Normalform.

=== PA_RESULT
*PA_RESULT* unterscheidet sich durch den zusammengesetzten Primärschlüssel aus *Stern* und *Kennung*. Das Nichtschlüsselattribut *EntscheidungsID* wird erst durch die Kombination beider Schlüsselbestandteile festgelegt; weder *Stern* allein noch *Kennung* allein reicht dafür aus.

Damit ist die zweite Normalform erfüllt, weil keine partielle Abhängigkeit vorliegt. Da *EntscheidungsID* das einzige Nichtschlüsselattribut ist, sind außerdem keine transitiven Abhängigkeiten möglich, sodass auch *PA_RESULT* in der 3NF liegt.

#pagebreak()

#let code_figure(path, lang: "sql") = figure(
  caption: [*#path*],
  kind: "code",
  supplement: [Code],
  block(
    stroke: 0.5pt,
    width: 100%,
    inset: 5pt,
  )[
    #set align(left)
    #set text(size: 8pt, font: "PT Mono")
    #raw(read(path), lang: lang)
  ],
)

== Aufgabe 4:
SQL Tabelleninitialisierung
#code_figure("code/A4.sql")
#pagebreak()

== Aufgabe 5:
Paketspezifizierung
#code_figure("code/A5.sql")

== Aufgabe 6/7:
Implementierung des Paketbodys
#code_figure("code/A6-7.sql")
#pagebreak()

== Aufgabe 8:
Anonymer Block zur Testausführung der Prozedur Action
#code_figure("code/A8.sql")
