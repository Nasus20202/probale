#set text(
  font: "New Computer Modern",
  size: 11pt
)
#set page(
  paper: "a4",
  margin: (x: 0.5cm, y: 1cm),
  numbering: "1 / 1",
  footer: context [
    #set text(8pt)
    #h(1fr)
    #counter(page).display(
      "1 / 1",
      both: true
    )
  ]
)
#set heading(numbering: "1.")
#let index() = {
  context [
    #set text(size: 11pt)
    #let to-string(content) = {
      if content.has("text") {
        content.text
      } else if content.has("children") {
        content.children.map(to-string).join("")
      } else if content.has("body") {
        to-string(content.body)
      } else if content == [ ] {
        " "
      }
    }

    #text(size: 16pt, weight: "bold")[Indeks pojęć]
    #v(2pt)
    #set block(above: 6pt, below: 0pt)

    #counter(heading).update(0)
    #for e in query(selector(heading)).sorted(key: x => upper(to-string(x))).filter(x => x.level == 2) [
      #link(e.location())[
        #grid(
          columns: (auto, 5pt, auto, 5pt, auto),
          e.body,
          [],
          repeat("."),
          [],
          str(e.location().page())
        )
      ]
    ]
  ]
}

#align(center)[
  #text(size: 15pt, weight: "bold")[Metody Probabilistyczne]
]

#outline(title: "Spis treści", indent: {auto}, depth: 2)
#index()
#pagebreak()

= Pytania o wszystkim i o niczym

== Probabilistyka - cele, umiejscowienie

=== Wyjaśnij rolę probabilistyki jako "interfejsu".

Probabilistyka jest interfejsem między procesami poznawczymi i decyzyjnymi w obecności mechanizmów losowych a matematyką. Pozwala dokonywać ocen ilościowych i jakościowych oraz ułatwia podejmowanie racjonalnych decyzji. Jako probabilistycy, jesteśmy klientami matematyki, a np. informatyka jest naszym klientem.

== Mechanizmy losowe i pseudolosowe

=== Wyjaśnij obiektywny i subiektywny walor pojęcia prawdopodobieństwa.
Obiektywny - opisuje część danego zdarzenia przy wielokrotnym uruchamianiu mechanizmu losowego w doświadczeniu losowym.
Subiektywny - opisuje stan wiedzy o danym mechanizmie losowym.

=== Jakie są elementy opisu modelu probabilistycznego doświadczenia losowego, czyli przestrzeni probabilistycznej?
Zbiór zdarzeń elementarnych oraz zdarzeń zdefiniowanych na podstawie zdarzeń elementarnych i ich prawdopodobieństwa.

=== Wymień podstawowe cechy dobrego generatora liczb pseudolosowych.
Każdą liczbę zwraca niemal tak samo często i bez uchwytnego związku z uprzednimi w bardzo długim cyklu.

=== Podaj znane Ci definicje prawdopodobieństwa.
- Klasyczna $P(A) = abs(A)/abs(omega)$
- Geometryczna $P(A) = abs(abs(A))/abs(abs(omega))$
- Aksjomatyczna
- Częstościowa


== Mity a fakty

=== Czy i ewentualnie kiedy na wykładzie obaliliśmy mit, że jeśli w każdym pokoleniu średnio przypada jeden potomek na osobnika, to populacja ma szansę przetrwać?
Populacja ma szansę przetrwać w badanym skończonym przedziale czasowym, lecz nie w nieskończoności. Obaliliśmy ten mit przy okazji problemu opróżnienia stosu.

=== Jaki rozkład prawdopodobieństwa mają pierwsze cyfry znaczące zgodnie z prawem Benforda?
Rozkład logarytmiczny.

=== Jak z probabilistycznego punktu widzenia zaklasyfikujemy ciąg kolejnych przewag orłów nad reszkami w serii rzutów monetą?
Ciąg przewag orłów nad reszkami w serii rzutów monetą można analizować jako losową wędrówkę, gdzie każdy rzut to krok w górę dla orła (+1) lub w dół dla reszki (-1). Prawdopodobieństwo, że przewaga orłów utrzyma się przez $n$ rzutów, wynosi około $1/2^n$. Średnia długość najdłuższego ciągu przewag orłów rośnie proporcjonalnie do pierwiastka kwadratowego liczby rzutów, czyli $log_2(n)$.

=== Na podstawie rysunku zamieszczonego na slajdzie podaj probabilistyczną przyczynę, dla której "statystyczny pasażer" poczeka na przystanku dłużej niż 5 minut.
Jeśli przychodzą trzy autobusy po sobie, pierwszy, potem drugi z czasem X po pierwszym (mniejszym od średniej) a potem trzeci z czasem Y po drugim (większym od średniej) to częściej statystyczny pasażer będzie trafiał w przedział Y, czyli będzie czekał dłużej od wartości średniej.

=== W kontekście "prześladowania przez pecha" co dokładnie rozumiemy przez "symetryczną sytuację losową"?
Prześladowanie przez pecha to złudzenie. Spośród symetrycznych doświadczeń losowych, mocniej zapamiętujemy te, które są na naszą niekorzyść. Przykładowo, jeżeli codziennie na przystanek przyjeżdża autobus, to zapamiętamy tylko te sytuacje, kiedy nie przyjedzie na czas. Czyli symetryczna sytuacja losowa to powtórzone doświadczenie pod tymi samymi warunkami.

=== W teście wyboru z 5 wariantami odpowiedzi za poprawną odpowiedź przyznawany jest 1 punkt, za niepoprawną $-1/4$ punktu. Wyjaśnij, w jakim sensie neutralizuje to efekt przypadkowego wyboru odpowiedzi.

Ponieważ przewidywany zwrot jest równy zero. Inaczej - średnio strzelając uzyskamy 0 punktów.

= Rozkłady prawdopodobieństwa

== iTrust

=== Gdy liczby agentów objętych dystrybucją zapytań ($z$) i metadanych ($m$) są równe $4sqrt(n)$ prawdopodobieństwo braku trafień oszacujemy jako...
$ P(T=0) < e^(-(m z)/n) = e^((-4sqrt(n)*4sqrt(n))/n) = e^(-16) $

== Symulator w hiperkuli

=== Wydajność generatora dopuszczalnych układów odchyłek dla symulatora systemu zależy w następujący sposób od dopuszczalnego promienia hiperkuli.
Nie zależy (na wzorze można pokazać).

=== W jaki sposób zastosowana została geometryczna definicja prawdopodobieństwa?
Prawdopodobieństwo jest równe stosunkowi miary obszaru hiperkuli do miary obszaru hiperkostki.

== Kod korekcyjny w przestrzeni Hamminga

=== Dlaczego w użytym przykładzie tabeli dekodowania żaden korygowany ciąg błędów nie może zawierać trzech jedynek?
Bo dla trzech jedynek mamy do czynienia z fatalnym błędem decyzyjnym. Moc korekcyjna naszego kodu sięga niektórych dwóch błędów

=== Ciągiem nadanym jest 10000, ciągiem błędów jest 01001. Jaką decyzję podejmie dekoder?
Odbierzemy 11001, czyli koder podejmie decyzję 01001, czyli będzie to błąd fatalny.

=== Wyjaśnij rolę zasady maksimum wiarygodności w konstrukcji kodu.
Na podstawie zasady maksimum wiarygodności wyprowadzamy metrykę Hamminga i wybieramy najbardziej wiarygodny ciąg bitów.

=== Jaka jest zasada konstrukcji tabeli dla dekodowania ciągów odebranych i na czym się ona opiera?
Pierwszy wiersz zawiera możliwe ciągi kodowe s. Pierwsza kolumna zawiera korygowalne ciągi błędów z. Pozostałe komórki zawierają odebrane sygnały y. Opiera się ona na zasadzie maksimum wiarygodności (sygnał y jest interpretowany jako najbardziej prawdopodobny ciąg s). Prawdopodobieństwo określane na podstawie liczby przekłamań (metryka Hamminga - im mniejsza tym bardziej prawdopodobny).

== Sieć sensorów

=== Co oznacza prawdopodobieństwo $P(Z_50_+ >= 2)$?
Prawdopodobieństwo, że po czasie 2 w sieci będzie żyło ponad 50 sensorów.

=== Ile według przyjętego modelu wynosi wartość średnia czasu życia jednego sensora?
Całka z rozkładu życia sensora, czyli mianownik w wykładniku potęgi, czyli u nas: 1 Rozkład życia $P(X_i >=x) = e^(-x)$z tego komplementarna $F(X) = 1 - e^(-x)$ z tego $p(x)$ i całka $x p(x)$ przez części ale tego nie trzeba pewnie liczyć w ogóle.
$ integral_0^infinity x e^(-x) d x = 1 $

=== Jaki według przyjętego modelu jest rozkład czasu życia sensora, który przetrwał najdłużej spośród 100 sensorów?
$ P(Z_0 >= x) = 1 - (1-e^(-x))^100 $