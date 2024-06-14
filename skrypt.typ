#let premium = false
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
  ],
  header: context [
    #set text(8pt)
    #counter(page).display(
      "1 / 1",
      both: true
    )
  ],
  background: context [
    #if not premium {
      image("./img/watermark_5.png", height: 50%)
    }
  ]
)
#set heading(numbering: "1.1.1")
#show heading.where(level: 1): set text(weight: "regular", size: 16pt)
#show heading.where(level: 2): set text(weight: "regular", size: 14pt)
#show heading.where(level: 3): set text(weight: "bold")
#show heading: it => [
  #if it.level < 3 {
    align(right)[#it]
  } else {
    [#it]
  }
]

#let toc() = {
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
    #text(size: 16pt, weight: "bold")[#align(center)[Spis treści]]
    #v(2pt)
    #set block(above: 6pt, below: 0pt)

    #counter(heading).update(0)
    #columns(
      2,
      gutter: 5pt,
      for e in query(selector(heading)).filter(x => x.level != 3) [
        #link(e.location())[
          #stack(
            dir: ltr,
            h(e.depth * 10pt),
            e,
            h(5pt),
            "(" + str(e.location().page()) + ")"
          )
        ]
      ]
    )
  ]
}

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
    #text(size: 16pt, weight: "bold")[#align(center)[Indeks pojęć]]
    #v(2pt)
    #set block(above: 6pt, below: 0pt)

    #counter(heading).update(0)
    #columns(
      2,
      gutter: 5pt,
      for e in query(selector(heading)).sorted(key: x => upper(to-string(x))).filter(x => x.level == 2) [
        #link(e.location())[
          #stack(
            dir: ltr,
            e.body,
            h(5pt),
            "(" + str(e.location().page()) + ")"
          )
        ]
      ]
    )
  ]
}

#align(center)[
  #text(size: 18pt, weight: "bold")[Kajecik Fazbera na Metody Probabilistyczne]
]

#toc()
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
Nie zależy (na wzorze można pokazać). Zależy jedynie od ilości wymiarów, w których jest określona.

=== W jaki sposób zastosowana została geometryczna definicja prawdopodobieństwa?
Prawdopodobieństwo jest równe stosunkowi miary obszaru hiperkuli do miary obszaru hiperkostki.

== Kod korekcyjny w przestrzeni Hamminga

=== Dlaczego w użytym przykładzie tabeli dekodowania żaden korygowany ciąg błędów nie może zawierać trzech jedynek?
Bo dla trzech jedynek mamy do czynienia z fatalnym błędem decyzyjnym. Moc korekcyjna naszego kodu sięga niektórych dwóch błędów

=== Ciągiem nadanym jest 10000, ciągiem błędów jest 01001. Jaką decyzję podejmie dekoder?
Odbierzemy 11001, czyli koder podejmie decyzję 01001, czyli będzie to błąd fatalny.

$
10000 -> "ciąg nadany S", 01001 -> "ciąg błędów Z"\
 11001 -> "ciąg odebrany" Y = S plus.circle Z, "wybieramy" S_d ", gdzie najmniej jedynek w" S_d plus.circle Y
$
#align(center)[
  #table(
    columns: 5,
    [$S_d$], [10111], [10000], [01110], [01001],
    [$S_d plus.circle Y$], [01110 (3)], [01101 (2)], [10111 (4)], [10000 (1)]
  )
]

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

== Wielodostęp rywalizacyjny

=== Jakie byłoby prawdopodobieństwo $P(X = k)$ gdyby $A$ były niezależne?
Takie samo, bo moglibyśmy je policzyć również z twierdzenia o kombinacji zdarzeń.

=== Jak wyglądałby rozkład $P(X=k), k = 0,1,...,n$ gdyby zdarzenia $A_i$ były rozłączne?
Gdy są nierozłączne może być kilka szczelin prostych naraz. Tylko jedno puste może zajść $k = 0$ lub $k = 1$.

=== Co jest większe: $abs(X = k)$ czy $binom(n, k) (n - k)^m$?
$binom(n, k) (n - k)^m$, bo doliczamy jeszcze, gdy $k + 1$, $k + 2$, ..., $n$ szczelin pustych. Jest to uogólnienie wzoru Bernoulliego.

=== Uzasadnij, że zdarzenia $A_1$, ..., $A_n$, gdzie $A_i$ - szczelina $i$ jest pusta, nie są rozłączne i nie są niezależne.
Nie są rozłączne, ponieważ może być kilka pustych szczelin naraz. Nie są niezależne, bo pustość jednej szczeliny zmniejsza prawdopodobieństwo pustości innej.

== Filtr Blooma

=== Dokładne wyliczenie prawdopodobieństwa fałszywego alarmy jest trudne z uwagi na...
Fakt, że "zapalanie" kolejnych bitów nie jest niezależne statystycznie. Można liczyć z twierdzenia o kombinacji zdarzeń, ale jest to uciążliwe ze względu na naprzemienną sumę.

== Fuzja danych

=== Wyjaśnij naiwność klasyfikatora
#image("img/2_7_1.png")
Niezależność zdarzeń nie implikuje niezależności tych zdarzeń pod wystąpieniem jakiegoś warunku jak ilustruje rysunek.

=== Podaj przykład relacji między zdarzeniami B i C zapewniającej warunkową niezależność statystyczną zdarzeń A i B na przykładowym wykresie Venna.
Powyższy rysunek: Wystąpienie/niewystąpienie $Z$ może wprowadzać statystyczną zależność pomiędzy sygnałami detektorów. Niemniej warunkowa niezależność sygnałów często jest zakładana.

=== Dlaczego bezpośrednie zastosowanie zasady maksimum wiarygodności nazwaliśmy naiwnym?
Niezależne zdarzenia $A$ i $B$ nie muszą pozostać takimi przy warunku $C$ - niezależność statystyczna na ogół nie implikuje warunkowej niezależności.

== Producenty i konsumenty

=== Niech $psi_(j,k)$ reprezentuje prawdopodobieństwo ostatecznego opróżnienia RK. Ułóż odpowiednią zależność rekurencyjną.
$
cases(
  psi_(j, k) = p * psi_(j + 1, k) + q * psi_(j, k - 1),
  psi_(j, 0) = 1,
  psi_(100, k) = 0
)
$

=== Co jest większe: $product_(j, k)$ czy $product_(j - 1, k - 1)$?
Większe jest $product_(j - 1, k - 1)$, ponieważ jest większe prawdopodobieństwo kroku w stronę zwiększenia $j$ a bufor konsumenta jest dalej od opróżnienia.

=== Czym od przedstawionego różniłoby się rozumowanie prowadzące do prawdopodobieństwa opróżnienia RK?
To wyżej z  $psi$.

=== W omawianym dwuwymiarowym błądzeniu przypadkowym występują dwa ekrany. Jakiego rodzaju?
Pierwszy ekran - przepełnienie RP $101k+100$, drugi ekran opróżnienie RK $101*100+j$.

== Rozproszony wybór lidera

=== Jaki sens ma wartość $l$ (małe L) w wyrażeniu na $P(T <= k)$?
Jest to liczba wylosowana przez lidera, czyli ciąg orłów i reszek zamieniony na liczbę. Może ona być z przedziału $[0, 2^k - 1]$ i służy nam w twierdzeniu o prawdopodobieństwie całkowitym.

== Sieć społecznościowa

=== Obliczając dynamikę $W(t)$ trzy razy korzystaliśmy z twierdzenia o prawdopodobieństwie całkowitym. Z jakich układów hipotez korzystaliśmy?
1. Zajście lub niezajście błędu implementacji lub interpretacji.
2. Spotkanie lub brak spotkania w ciągu $d t$.
3. Reputacje uczestnika i partnera, korzystając z $W(t)$ do obliczenia prawdopodobieństw hipotez.

=== Obliczając $h_(x y)$ stosujemy twierdzenie o prawdopodobieństwie całkowitym. Co jest tutaj układem zupełnym zdarzeń?
Wystąpienie/nie wystąpienie błędu implementacji/interpretacji

=== Opisz układy zupełne zdarzeń wykorzystywane w rozumowaniu prowadzącym do określenia dynamiki procesu $W(t)$.
Na odcinku czasu wystąpi lub nie wystąpi interakcja. Jeśli wystąpi interakcja, to układ zupełny z 4 hipotezami $->$ losowy uczestnik i losowy partner mogą mieć niską lub wysoką reputację

== Szybkie sortowanie

=== Wyjaśnij sens równania $e k|k = n - 1 + e k + e n - 1 - k$.
Równanie rekurencyjne liczby potrzebnych porównań dla przypadku w którym wylosowana liczba jest większa od k liczb w sortowanym zbiorze. W tym wywołaniu wykonujemy $n-1$ porównań (pivoting), oraz ilość porównań potrzebną do posortowania zbiorów o rozmiarze k oraz o rozmiarze $n-1-k$.

== Odtwarzanie tras pakietów IP

=== Dlaczego słupki rozkładu odciętego są wyższe niż nieodciętego?
Ze względu na to, że masa prawdopodobieństwa przeniesiona została z ogona do tego przedziału, do którego obcięliśmy model. Jest to reprezentowane przez warunek normalizacyjny.

=== Jaki sens mają wielkości losowe $X_1$, ..., $X_d$ w problemie zbieracza kuponów?
Są to czasy czekania natrafienie na kolejny kupon (kolor), którego jeszcze nie mamy.

== Optymalizacja polityki terminacji

=== Dlaczego dla rozważanej klasy polityk terminacji wystarczająca jest skończona tablica STOP/KONT?
Od pewnego momentu w wierszach i kolumnach tablicy są same wartości STOP.

=== Dlaczego nie jest poprawna polityka terminacji "znajdź pozycję w ciągu prób, dla której $a$ jest maksymalne i podejmij wówczas decyzję STOP"?
Bo tę decyzję musimy podjąć na bieżąco, a nie po poznaniu całego ciągu. Jeżeli moglibyśmy podjąć ją po poznaniu całego ciągu, to zawsze bylibyśmy w stanie podjąć decyzję optymalną.

=== Wyjaśnij probabilistyczny sens równania $e(o, r) = 1/2 e(o + 1, r) = 1/2 e(o, r + 1)$.
Równanie to można interpretować probabilistycznie jako przewidywanie prawdopodobieństwa wystąpienia zdarzenia e w punkcie $(o,r)$ na podstawie prawdopodobieństw wystąpienia tego samego zdarzenia w sąsiednich punktach: $(o+1, r)$ i $(o, r+1)$.

== Testowanie oprogramowania

=== Co reprezentują wielkości losowe $B$ i $G$?
$B$ to liczba niepoprawnych modułów jeśliby zakończyć testowanie na etapie $i$. $G$ to liczba przetestowanych modułów do następnego etapu, czyli do natrafienia na niepoprawny. Jest to koszt przejścia z danego etapu do następnego jeśli wybrano kontynuację.

=== Wyjaśnij słownie w terminach wartości oczekiwanych optymalną regułę decyzji KONT/STOP w kolejnych etapach.
Wybieramy tą decyzję, która ma mniejszy koszt. Kontynuacja to koszt wykonania testów. Stop to ryzyko awarii krytycznej spowodowanej błędnym modułem

=== W którym momencie zastosowaliśmy uogólnione pojęcie wartości średniej?
Liczenie kosztu kontynuacji: $E h (B_(n- y, p) / h)$

== Generałowie bizantyjscy

=== Jakiej informacji nie wykorzystuje zasada maksimum wiarygodności w porównaniu do twierdzenia Bayesa?
Nie korzysta ona z informacji o prawdopodobieństwie zostania bizantyjskim generałem przez agenta. Nie zakłada, że dzieje się to w sposób niezależny.

=== Jakie różnice między wynikami dla twierdzenia Bayesa i zasady maksimum wiarygodności zaobserwowaliśmy przyjmując, że liczba agentów typu BG może być dowolna od 0 do 100 z jednakowym prawdopodobieństwem?
Wówczas wyniki byłyby do siebie proporcjonalne, nie obserwowalibyśmy różnic w kształtach tzn. $P(H_i/R = k) ~ P(R = k|H_i)$ (przeskalowane o współczynnik normalizacji).

=== Jak mierzyć niepewność uzyskanych wyników? Dlaczego w przypadku zasady maksimum wiarygodności jest ona większa w porównaniu z twierdzeniem Bayesa?
Niepewność uzyskanych wyników możemy mierzyć przez rozproszenie słupków histogramu od maksimum. Dla zasady maksimum wiarygodności nie wykorzystujemy znajomości o prawdopodobieństwie zostania przez agenta bizantyjskim generałem, dlatego nie jest faworyzowana mniejsza ich ilość dla mniejszej liczby niepoprawnych odpowiedzi, co mogłoby stanowić czynnik przyczyniający się do zredukowania niepewności.

== System reputacyjny Beta

=== Jak na jakość eliminacji nieuczciwych klientów wpłynęłoby zastąpienie parametrów kwantyl $0.95$ i kwantyl $0.05$ przez kwantyl $0.9$ i kwantyl $0.1$?
Więcej klientów zostałoby uznanych za oszczerców i wspólników.

=== Czy zastosowanie kwantyli rzędu $0.01$ i $0.99$ zamiast $0.05$ i $0.95$ w skróciłoby, czy wydłużyło opisaną procedurę eliminacji nieuczciwych klientów?
Wydłużyłoby, ponieważ w każdej iteracji system byłby bardziej uważny przy odrzucaniu nieuczciwej liczby klientów i odrzucał by ich mniej.

=== Do wypracowania oceny $z^*$ wykorzystuje się rozkład a posteriori $p(z|w, n)$. Z punktu widzenia twierdzenia Bayesa, co reprezentuje $z$, a co $w$ i $n$?
$z$ należy do zbioru ciągłego układu zupełnego hipotez. Jego wartość należy do $[0, 1]$ i jest hipotezą, że poziom zaufania agenta = z. \
$w$ - liczba raportów o wysokiej satysfakcji \
$n$ - liczba raportów o niskiej satysfakcji \
$w, n$ - to co już zaszło i o tym wiemy \

=== Dla ograniczenia efektów nieuczciwych raportów ocenę $z^*$ porównuje się z jaką charakterystyką rozkładu $p(z|w, n)$?
Ocenę większościową $z^*(M)$ porównujemy z kwantylami rozkładu otrzymanego dla $w$ i $m$ tylko danego klienta. Jeśli ocena jest mniejsza lub większa od progowego kwantyla to klienta uznajemy za nieuczciwego.

=== Rozkład beta jest pewnym warunkowym rozkładem gęstości prawdopodobieństwa - jakiej wielkości losowej i przy jakim warunku?

Rozkład beta jest określony dla dwóch parametrów, $alpha$ i $beta$, które są parametrami kształtu. Wartości tych parametrów wpływają na kształt rozkładu gęstości prawdopodobieństwa. Zmienna losowa $X$ z rozkładem beta ma gęstość prawdopodobieństwa określoną wzorem:

$ f(x|alpha, beta) = (x^(alpha - 1) (1-x)^(beta - 1))/B(alpha, beta) \
x "jest wartością zmiennej losowej," \
alpha > 0 "jest parametrem kształtu," \
beta > 0 "jest drugim parametrem kształtu," \
B(alpha, beta) "jest funkcją beta, która normalizuje rozkład (całka gęstości prawdopodobieństwa od 0 do 1 równa 1)."
$


== Metoda odwracania dystrybuanty

=== Jakie przekształcenie generuje liczby losowe o rozkładzie $f(x)$?
Liczby losowe o rozkładzie $f(x)$ generuje funkcja odwrotna. Czasami trzeba zrobić całke $f(x)$
jak p(x) podane.

$
p(x) = 1/a e^(-x/a) =>
X = - a ln(1 - U)
$
$
F(x) = 0.5 + arctan(x)/pi =>
X = tan(pi(U - 1/2))
$
$
F(x) = 1 - e^(-x^b/a) =>
X = root(b, - a ln(U))
$
$
p(x) = 2x =>
X = sqrt(U)
$

== Naturalne zbiory danych

=== Jaki jest fizyczny sens stałej $k$ w wyrażeniu $P(X < x) = P(k X < x)$?
Naturalna zmienna losowa nie może zależeć od skali (jednostki), czyli prawdopodobieństwo $X$ musi być takie samo jak $k X$, gdzie $k > 0$ jest dowolną stałą.

= Sumy niezależnych wielkości losowych

== Funkcje charakterystyczne i tworzące / Rozkłady sum

=== Jakiej operacji na niezależnych wielkościach losowych odpowiada mnożenie ich funkcji charakterystycznych?
Dodawaniu tych wielkości.

=== Dodawanie niezależnych wielkości losowych odpowiada następującym operacjom na ich rozkładach prawdopodobieństwa i funkcjach charakterystycznych:
na rozkładach: splot, na funkcjach charakterystycznych: mnożenie

=== Jak z funkcji charakterystycznej otrzymać rozkład prawdopodobieństwa dyskretnej wielkości losowej?
Korzystając z twierdzenia o jednoznaczności

=== Jak z funkcji tworzącej otrzymać rozkład prawdopodobieństwa dyskretnej wielkości losowej?
Korzystając z rozwinięcia w szereg potęgowy

=== Czy słuszne jest stwierdzenie, że funkcja tworząca jest szczególnym przypadkiem funkcji charakterystycznej, gdzie $e j u = z$? Uzasadnij.
$ g(X) = cases(
  e^(j v X) X "ciągła o zbiorze realizacji" x in [a, b],
  z^X X "dyskretna o zbiorze realizacji" x in {0, 1, 2, ...}
) $
Jest, charakterystyczna to całkowanie, tworząca to dodawanie. Różnica jest w dziedzinie.

== Równoważenie obciążenia: round robin

=== Jaki rozkład ma interwał między dwoma kolejnymi wywołaniami do danego serwera w obecności 5 równoległych serwerów?
Rozkład Erlanga-5.

=== Jaka własność funkcji charakterystycznej jest wykorzystywana przy dodawaniu niezależnych wielkości losowych?
Funkcja charakterystyczna sumy niezależnych wielkości losowych jest równa iloczynowi funkcji charakterystycznych tych zmiennych.

=== W jaki sposób liczba równoległych serwerów wpływa na rozkład interwału widzianego przez ustalony serwer?
Czym więcej serwerów, tym jest to rozkład Erlanga-n o większym $n$. Wówczas, masa prawdopodobieństwa przesuwa się w kierunku wyższych wartości.

=== Rozkład Erlanga powstaje w wyniku dodawania niezależnych wielkości losowych o rozkładach...
wykładniczych

== Zaległości w obsłudze

=== W wyniku czego powstaje rozkład Erlanga rzędu $k$?
W wyniku $k$-krotnego splotu rozkładu wykładniczego.

=== Skąd bierze się jakościowa różnica w wykresach prawdopodobieństwa naruszenia reżimu czasu rzeczywistego?
Z różnicy w czasach wykonania pojedynczego przerwania. Jeśli przychodzące przerwania zajmują nam dużo czasu to prawdopodobieństwo zaległości jest wysokie.

=== W wyniku dodawania niezależnych wielkości losowych o rozkładach równomiernych powstaje rozkład...
Irwina-Halla

== Utracone wywołaniami

=== Jaki jest związek między rozkładem Poissona a rozkładem geometrycznym?
Jeżeli dla ilości wywołań opisywanych rozkładem Poissona przyjmiemy losowy przedział czasu o rozkładzie wykładniczych (czyli $T$ zamiast $t$) to ilosc wywołan w tym losowym przedziale bedzie miała rozkład geometryczny (mozna to wyprowadzic z twierdzenia o prawdopodobienstwie całkowitym).

=== Jeżeli liczba wywołań w danym przedziale czasowym ma rozkład Poissona, to jaki jest rozkład liczby wywołań utraconych w czasie awarii o losowym czasie trwania o rozkładzie wykładniczym?
Jest to rozkład geometryczny.

=== Jeżeli liczba wywołań w danym przedziale czasu ma rozkład Poissona, to jaki jest rozkład interwału między dwoma kolejnymi wywołaniami?
Jest to rozkład wykładniczy.

=== Jaki rozkład prawdopodobieństwa odpowiada funkcji charakterystycznej będącej pojedynczą eksponentą?
Atom w jednym punkcie, a reszta jest rozłożona jak krzywa wykładnicza.

== Opróżnianie stosu

=== W przykładzie dla $P(N = 0) = 0.3$, $P(N = 1) = 0.2$, $P(N = 2) = 0.2$, $P(N = 3) = 0.1$ prawdopodobieństwo, że populacja w drugim pokoleniu wymrze wynosi...
$ P(Y^(2) = 0) = 0.4407 $

=== Jakie jest prawdopodobieństwo ostatecznego wymarcia populacji przy $P(N = 0) = 0.3, P(N = 1) = 0.4, P(N = 2) = 0.2, P(N = 3) = 0.05$.
Korzystamy z metody Newtona (iteracyjnym przybliżaniu pierwiastka równania) \
$q = 0.3 + 0.4q +0.2q^2 + 0.05q^3$ (przyrównujemy to do 0, czyli przenosimy q na drugą) \
$f(q) = 0.05q^3 + 0.2q^2 - 0.6q + 0.3$ (obliczamy z tego pochodną) \
$f'(q) = 0.15q^2 + 0.4q - 0.6$ \
$q_(n+1) = q_n - f(q_n)/(f'(q_n))$ \
Jako $q_0$ wybieramy 0 i podstawiając do $f(q)$ i $f'(q)$ obliczamy wartości. Podstawiamy je do wzoru na kolejne $q$ i mamy $q_1$. Następnie obliczamy $q_2$ za pomocą $q_1$ itd. \
$q_0 = 0 -> q_1 = 0.5 -> q_2 = 0.65517 -> q_3 = 0.67964$ \
$product = 0.68078$

=== Prawdopodobieństwa liczby bezpośrednich potomków są następujące: 0 - 30%, 1 - 40%, 2 - 20% i 3 - 10%. Jaka jest szansa, że populacja nie wymrze?
Szansa że wymrze, to 0.791, czyli że przeżyje to 1-0.791 = 0.209

=== Jeżeli równanie $product = G_N (product)$ ma dwa rozwiazania, to co można powiedzieć o prawdopodobienstwie, że stos ponownie się opróżni?
Jest ono równe mniejszemu z tych dwóch prawdopodobieństw, czyli $product = min{product_1, product_2}$. Nie ma pewności czy się opróżni, czy nie.

=== Jaka jest probabilistyczna interpretacja nachylenia krzywej $G_n (z)$ w punkcie 1?
Jest to wartość średnia liczby bezpośrednich potomków $G'_n (1) = E N$. Jeśli $E N <= 1$ to populacja na pewno wymrze. W przeciwnym wypadku, istnieje niezerowe prawdopodobieństwo, że stos się już nigdy nie opróżni. \
Dla tych parametrów wymrze: 0.791, przetrwa: 0.209

== Słabe prawo wielkich liczb: eksperyment

=== Gdyby rozkład $X$ był wykładniczy, to do którego z pokazanych przebiegów podobny byłby analogicznie otrzymany przebieg w funkcji $n$?
Byłby analogiczny do rozkładu równomiernego, bo ma skończoną wartość średnią.

=== Co możemy powiedzieć o wartości średniej rozkładu Cauchy'ego?
Nie istnieje, ponieważ nie działa prawo wielkich liczb. Wielokrotnie powtórzone doświadczenie daje statystycznie tak samo dobry wynik jak pojedyncza iteracja.

=== Co jest powodem narastania trendu przebiegu $(S_n)/n$ w funkcji $n$ dla wielkości losowej $X$ o rozkładzie Pareto?
Jest to spowodowane faktem, że rozkład Pareto z takim współczynnikiem kształtu ma wartość średnią nieskończoną, zatem dąży do nieskończoności.

=== Który parametr rozkładu Pareto należałoby zmienić, aby uzyskać przebieg $(S_n)/n$ w funkcji $n$ podobny jak dla wielkości losowej $X$ o rozkładzie równomiernym?
Należałoby zmienić współczynnik kształtu tak, żeby otrzymać wartość średnią skończoną. Należy go ustalić $k > 1$.

=== Czy w wariancie Chinczyna słabe prawo wielkich liczb działa dla każdego typu rozkładu prawdopodobieństwa obserwacji?
Nie, nie będzie on działał dla rozkładu, który nie ma średniej, czyli np. dla Cauchy'ego.

== Centralne twierdzenie graniczne

=== W odróżnieniu od słabego prawa wielkich liczb, w wariancie Chinczyna centralne twierdzenie graniczne wymaga, aby...
wielkość losowa miała skończoną wariancję.

=== Czy statystycznie niezależne wielkości losowe o jednakowych rozkładach spełniają słabe prawo wielkich liczb i twierdzenie graniczne i pod jakimi warunkami?
Słabe prawo wielkich liczb tak, pod warunkiem, że istnieje wartość średnia. Centralne twierdzenie graniczne (Ctg) tak, pod warunkiem, że istnieje skończona wariancja.

=== Co zaobserwujemy dodając do siebie wiele rozkładów wykładniczych?
Zaobserwujemy kolejne rozkłady Erlanga-n, które będą coraz bardziej przypominać krzywą dzwonową. Rozkład wykładniczy ma skończoną wariancję.

== Serwer webowy

=== Aby obliczyć $P(99000 <= S_40000 <= 101000)$ potrzebna nam jest wartość funkcji Laplace'a dla...
$ Phi((101000 - 40000 * 2.5)/(sqrt(40000) * 1.369)) - Phi((99000 - 40000 * 2.5)/(sqrt(40000)*1.369)) = 2 Phi(3.652) $
$ sigma = sqrt(10*0.25*(1-0.25)) \ 
P(a <= S_n < b) = Phi((b - n * m)/(sqrt(n) * sigma)) - Phi((a - n * m)/(sqrt(n)*sigma)) $

== Eksperyment Wolfa

=== Jakie odchylenie standardowe miałby rozkład wielkości losowej $(S_n)/n$ przy założeniu, że eksperyment obejmował nie 20000, lecz 200 rzutów kostką?
$ s = 0.373/sqrt(200) $

=== Co gdyby rozkład obejmował 200 rzutów?
Hipoteza, że kostka jest uczciwa byłaby bardziej wiarygodna, bo mielibyśmy większe odchylenie standardowe.

== Czas trwania sesji

=== Gęstość prawdopodobieństwa przekształconej wielkości losowej otrzymujemy zakładając, że przekształcenie $g$ spełnia warunki...
gładkość, odwracalność

=== Dystrybuantę przekształconej wielkości losowej otrzymujemy zakładając, że przekształcenie $g$ spełnia warunki...
odwracalność

=== Dla jakiej funkcji $g$ rozkład wielkości losowej $Y = g(X)$ ma ten sam kształt co rozkład X?
Dla funkcji liniowej. Pochodna musi być stała.

=== Jaka jest zasada konstrukcji wykresu Q-Q i co taki wykres nam daje?
Jest to wykres kwantyl funkcji dopasowywanej do kwantyla empirycznego. Dzięki temu możemy mierzyć jakość dopasowania - idealnie prosta. Zasada tworzenia - w celu dopasowania jak najlepszego rozkładu.

=== Jaki byłby kształt rozkładu $Z$, gdyby przyjąć $g(x) = a x + b "(a, b - stałe)"$?
Taki sam jak kształt S, bo pochodna stała.

== Atak na Wi-Fi

=== Jakie zagadnienie rozstrzyga nierówność Popoviciu?
Pozwala nam określić maksymalną wariancję dla wszystkich rozkładów ${X_1}, ..., {X_n}$.

=== Czym należy zastąpić warunek $n >= 663.6 sigma^2$, jeżeli wymagany procent pewności zmniejszymy do 98%?
Odczytujemy argument funkcji Laplace'a dla $0.49$ i oznaczamy go przez $k$. Wtedy $n >= k^2 sigma^2 / 0.01$.

= Ogony rozkładów prawdopodobieństwa

== Częstość anomalii w sygnale

=== Podaj szkic obliczenia wartości $0.25%$ dla szumu w kanale.
$ P("szum" > 50) = P("szum" > 20 sigma_"szum") <= 1/(20^2) = 0.0025 $

=== Gdyby odchylenie sygnału wejściowego było o 50% większe $P(abs("out" - E) > 50)$ byłoby ograniczone nie przez $2.4%$, tylko przez
$
P(abs(X - E X) >= c sigma) <= 1/c^2 \
"Wartość dla" P(abs("sygnał" - E) > 50) <= 2.4% \
50 = c * 7.76 => c = 6.44 \
P(abs("sygnał" - E) > 50) <= 1/6.44^2 = 2.4% \
"W zadaniu" sigma "ma się równać" 1.5 * 7.76 "czyli" 11.64 \
50 = sigma * c ", a więc" c = 50/11.64 = 4,296 \
P(abs("sygnał" - E) > 50) <= 1/4.296^2 = 5.4%
$

= Łańcuchy Markowa

== Jednorodny łańcuch Markowa I rzędu
Macierz przejść jednorodnego łańcucha Markowa I rzędu ma następujące własności:
- Jest to macierz kwadratowa, stochastyczna, czyli $sum_(j=0)^s m_(i j) = 1$
- Komórki reprezentują niezmienne w czasie prawdopodobieństwa przejść między stanami: $P(X_t = j | X_(t-1) = i) = m_(i j)$
- Niech $p(0)$ oznacza rozkład stanów w chwili początkowej, wówczas korzystając z macierzy $M$ możemy policzyć $p(t) = p(0) M^t$
- Natomiast $M^t$ jest również macierzą stochastyczną. Wartości własne tej macierzy spełniają równanie $1 = lambda_0 >= ... >= lambda_S$

== Sztuczne źródła tekstowe

=== Jak wielką przestrzeń stanów musielibyśmy rozważać, gdyby generacji tekstu na podstawie częstości $n$-gramów dokonywać przy pomocy łańcuchów Markowa 1 rzędu?
$ abs(S)^(n-1)", S to liczba możliwych znaków" $

=== Jaki byłby rozmiar macierzy przejść w sztucznym generatorze tekstu opartym na łańcuchach Markowa I rzędu operującym częstościami $n$-gramów?
$ abs(S)^(n-1) times abs(S)^(n-1) $

=== Wyjaśnij, dlaczego do analizy w zasadzie wystarczają nam łańcuchy Markowa I rzędu.
Bo każdy łańcuch wyższego rzędu można zredukować do łańcucha 1. rzędu kosztem wykładniczego wzrostu ilości stanów.

=== Liczba stanów łańcuchów Markowa I rzędu do analizy quadrogramów na tekstach angielskich wynosi
$26^3$ lub $27^3$ (uwzględniając spacje, na slajdach uwzględniona) \
$abs(S)^2$ dla trigramów w I rzędzie (pamiętamy 2 ostatnie)

== Ergodyczność łańcucha Markowa

=== Co przesądza o szybkości zbieżności do rozkładu granicznego?
Druga wartość własna $lambda_1$ macierzy $M$. Im mniejsza, tym szybsza zbieżność.

=== Jaki jest rozkład graniczny jednorodnego dwustanowego łańcucha Markowa o macierzy przejść $M = mat(1/2, 1/2; 1/4, 3/4)$
$(pi_1, pi_2) mat(1/2, 1/2; 1/4, 3/4) = (pi_1, pi_2) #h(2cm)
cases(
  1/2 pi_1 + 1/4 pi_2 = pi_1,
  1/2 pi_1 + 1/4 pi_2 = pi_2
) #h(2cm)
pi_1 = 3/4, pi_2 = 1/4 => pi = (3/4, 1/4)
$

== PageRank

=== Jak z punktu widzenia markowskiego modelu probabilistycznego należy interpretować współczynnik tłumienia w podstawowej formule PageRank?
Jest to prawdopodobieństwo, że internauta nieskończenie błądzący po internecie nie zrestartuje przeglądania. Prawdopodobieństwo to stanowi współczynnik proporcjonalności między PageRank, a częstością odwiedzin strony w błądzeniu losowym.

=== Współczynniki PageRank odpowiadają następującej charakterystyce łańcucha Markowa I rzędu...
$ p_j/d = (1-d)/s + sum_i p_i/a_i $

== Rozpoznawanie mowy

=== Gdyby jako sygnaturę ciągu $X$ ustalić rozkład długości $3$-paczek to w porównaniu z otrzymanymi na wykładzie byłby on...
o wolniejszym spadku wraz ze wzrostem $k$, ponieważ prawdopodobieństwo $3$-paczki długości $k$ jest większe niż ciągu jedynek długości $k$. $3$-paczki obejmują też wszystkie $1$-paczki, a ciąg jedynek to właśnie $1$-paczka.

=== Opisz zasadę tworzenia ciągu binarnego zgodnie z mechanizmem ukrytego łańcucha Markowa.
Mamy dwa stany, jeżeli znajdujemy się w danym kroku w stanie $1$ to $P$ wypisania jedynki jest równe $b_1$, a zera $1-b_1$, natomiast w stanie $2$ wypisanie jedynki jest równe $b_2$, a zera $1-b_2$ (czyli generujemy z pewnym prawdopodobieństwem zależnym od stanu).

= Wektory losowe i korelacja

== Korelacja: wariancja X+Y

=== Dane są wielkości losowe X i Y o znanych odchyleniach standardowych $sigma_X$ i $sigma_Y$. Jaka jest największa możliwa wartość $V(X+Y)$?

$ V(X+Y) = V X + V Y + 2 gamma_(X Y) <= sigma_X^2 + sigma_Y^2 + 2 sigma_X sigma_Y = (sigma_X + sigma_Y)^2 $

== Korelacja, a zależność statystyczna

=== Określ korelację i zależność statystyczną pomiędzy wielkościami losowymi $X$ i $Y$, gdzie 
$X = cos(U), Y = sin(U), p_U = 1/2 pi, u in [-pi, pi]$

Są nieskorelowane, ale zależne (jedynka trygonometryczna). $X^2 + Y^2 = 1$ - zależne. Po scałkowaniu i obliczeniu $E(X Y) - E(X) E(Y)$ wychodzi 0 - nieskorelowane.

=== Jak mają się do siebie własności korelacji i zależności statystycznej składowych wektora losowego?
Jeżeli składowe wektora są niezależne, to są nieskorelowane (cov = 0). Jeżeli są nieskorelowane, to z tego nie wynika niezależność - patrz zad. wyżej.

== Regresja liniowa

=== Jaki wpływ ma unormowany współczynnik kowariancji na prostą regresji i błąd średniokwadratowy regresji?
Od tego współczynnika zależy współczynnik kierunkowy prostej. Przykładowo, ujemnie skorelowane skutkują w prostej malejącej. Ponadto, im bardziej skorelowane zmienne, tym mniejszy błąd średniokwadratowy. Błąd ten wynosi 0 dla korelacji liniowej. Natomiast jest maksymalny, gdy współczynnik korelacji wynosi 1. Czym bardziej skorelowane tym lepiej (nie ważne czy dodatnio czy ujemnie).

=== Jak wygląda prosta regresji w przypadku, gdy $X i Y$ są nieskorelowane?
W przypadku, gdy zmienne $X$ i $Y$ są nieskorelowane, współczynnik kierunkowy $beta_1$ w prostym modelu regresji liniowej będzie bliski lub równy zeru, co oznacza, Że nie ma liniowego związku między $X$ i $Y$. W takiej sytuacji, najlepszym estymatorem dla $Y$ byłaby po prostu średnia $Y$, ponieważ $X$ nie dostarcza żadnej dodatkowej informacji, która mogłaby pomóc w przewidywaniu $Y$. \
Zatem równanie prostej regresji przy braku korelacji między $X$ i $Y$ sprowadza się do: $ Y = beta_0 + epsilon$, gdzie $beta_0$ będzie równy średniej $Y$.

== Stratna kompresja obrazu

=== Optymalna stratna kompresja obrazu wymaga, by kolumny macierzy do obrotu wektora pikseli spełniały następujące warunki:
żeby były m największymi wartościami własnymi macierzy kowariancji $Gamma$. Wtedy jako kolumny macierzy wstawiamy wektory własne macierzy kowariancji o tych wartościach.

=== Opisz operację macierzową prowadzącą do dekorelacji ciągu pikseli.
Operacja ta polega na obrocie układu współrzędnych za pomocą macierzy $Q$, której kolumny są największymi wektorami własnymi macierzy kowariancji $Gamma$. Obrót ten prowadzi do zapisania $n$ wartości pikseli za pomocą $m$ wartości, gdzie $m <= n$.

=== Które charakterystyki macierzy kowariancji ciągu pikseli są istotne z punktu widzenia optymalizacji stratnej kompresji obrazu?
Istotne są odpowiednie wektory własne macierzy.

=== Jak należy dobrać kolumny macierzy przekształcenia $Q$, aby zdekorelować piksele i zminimalizować stratność kompresji?
Błąd ten zminimalizujemy, gdy kolumnami macierzy $Q$ uczynimy wektory własne macierzy.

= Estymatory

== Próbka losowa populacji

=== Podaj warunki probabilistyczne, jakie powinna spełniać prawidłowo pobrana próba losowa z populacji.
Prosta - $X_i$ są niezależne. Reprezentatywna - $X_i ~ X$ (rozkład cech osobnika i taki jak rozkład cech całej populacji).

== Estymatory maksimum wiarygodności

=== Jaki jest wpływ błędów statystycznych poszczególnych obserwacji na ocenę wartości średniej w populacji o modelu $N(a, sigma)$?
Czym większy błąd statystyczny danej próbki, z tym mniejszą wagą uwzględniamy ją przy estymacji wartości średniej. Ma to sens, gdyż obserwacje są dla nas mniej wiarygodne, skoro obarczone są większym błędem.

== Monte Carlo: redukcja wariancji

=== Która z dwóch wielkości: $V X + V Y$ oraz $V(X + Y)$ jest większa?
To zależy od ich korelacji. \
Jeżeli jest ujemna to $V(X + Y) < V X + V Y$ \
Jeżeli dodatnia to $V(X + Y) > V X + V Y$ \
Jeżeli zerowa to $V(X + Y) = V X + V Y$ czyli wtedy, kiedy $X$ i $Y$ są niezależne.

=== Jaki efekt przyniosłaby metoda zmiennych parami przeciwstawnych, gdyby dla $k=1,3,5...$ przyjąć $U_((k+1)) = U_((k))?$
Zmniejszenia odchylenia standardowego.

== Prognoza ataków dnia zerowego

=== Jak wzrost liczby typów zaobserwowanych ataków przekładałby się na jakość prognozy ataków dnia zerowego?
Otrzymalibyśmy wówczas mniej efektywny estymator.

=== Co reprezentuje otrzymana wartość $14376 - 4343 + 2292 - ... = 11430$: estymator? obciążenie  estymatora? ocenę? bład statystyczny oceny? coś innego?
Estymatę, czyli konkretną ocenę dokonaną przez estymator. A konkretnie liczbę nowych typów. Natomiast 178 to błąd statystyczny oceny.

== Przedziały ufności - wyznaczanie

=== Dla ustalonych $n$ i $z$ szerokość przedziału ufności rośnie wraz z...
Ze wzrostem $delta$, ponieważ wówczas pozwalamy na to, że $a$ może przyjmować szersze spektrum wartości.

== Robak sieciowy

=== Gdyby przy $n = 1000$ i $z = 0.2$ jako poziom ufności przyjąć $99%$, to czy mogłaby być poprawna wartość $P(0.1697 < a < 0.2324) = 0.99$?
Nie, ponieważ nie wyznaczamy prawdopodobieństwa tego, że $a$ należy do jakiegoś przydziału, bo $a$ nie jest zmienną losową. Zamiast tego wyznaczamy prawdopodobieństwo tego, że kolejne wyznaczone przedziały ufności będą zawierały $a$.

=== Gdyby przy $n = 1000$ i $z = 20%$ jako poziom ufności przyjąć $delta = 90%$, to czy spodziewany rezultatem jest $J delta (z) = [0.16, 0.24]$? Uzasadnij.
Nie, prawdziwy wynosi $[0,1801,0,2216]$. Ponieważ wraz ze spadkiem poziomu ufności, "ufamy" mniejszej ilości rozwiązań, więc przedział się zwęża a nie rozszerza.
#align(center)[
  #table(
    columns: 4,
    [n], [z], [$delta$], [$J_delta (z)$],
    [1000],  [0.2],  [0.95], [[0.1764, 0.2260]],
    [1000],  [0.2],  [0.90], [[0.1801, 0.2216]],
    [10000], [0.2],  [0.95], [[0.1923, 0.2080]],
    [1000],  [0.25], [0.95], [[0.2242, 0.2778]]
  )
]

=== Gdyby przy $n = 1000$ i $z = 20%$ jako poziom ufności przyjąć $delta = 99%$, to czy mogłaby być prawdziwa równość $P(a in [0.1619, 0.232]) = 0.99$?
Nie, jeżeli np. $a = 0.17$ to $P = 1$, jeżeli $a = "np." 0.1$ to $P = 0$, a nie $50/50$. Patrz wyżej.

= Testowanie hipotez

== Policer SLA

=== Czy hipotezę $H_0$ częściej będziemy odrzucać na poziomie istotności $5%$ niż na poziomie istotności $1%$?
Częściej będziemy odrzucać dla $5%$, ponieważ ma większy obszar odrzucenia.

=== Kiedy definiujemy prawostronny, a w jakiej sytuacji lewostronny obszar odrzucenia $O_alpha$?
Prawostronny, jeśli duże wartości $accent(A, hat)$ przemawiają przeciwko $H_0$. Lewostronny, jeśli małe.

=== Dlaczego w teście serii przyjęliśmy dwustronny obszar odrzucenia?
Bo i male i duże ilości serii przemawiają przeciwko temu, że próba jest prosta.

== Test istotności

=== Gdy wyznaczona wartość $p$-value jest wyższa niż przyjęty poziom istotności, to czy powinniśmy odrzucić hipotezę zerową?
Gdy jest wyższa to bezpieczniej czujemy się nie odrzucając.

=== Gdy wyznaczona wartość $p$-value jest niższa niż przyjęty poziom istotności, powinniśmy odrzucić hipotezę zerową?
Tak, powinniśmy odrzucić hipotezę zerową, ponieważ dla mniejszych poziomów istotności byśmy to odrzucili. Odrzucając to czujemy się tym bezpieczniej, im mniejsza jest $p$-value.

=== Gdy wyznaczona wartość $p$-value jest wyraźnie niższa niż przyjęty poziom istotności, czujemy się bardziej, czy mniej komfortowo odrzucając hipotezę zerową?
Gdy jest niższa to odrzucając czujemy się bezpieczniej.