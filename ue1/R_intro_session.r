### Beispiel für Ausdruckskraft: Häufigkeit von k Richtigen beim Lotto

lotto = replicate(3, sample(1:49, 6))	# 3 maliges Stickprobeziehen:
 
lotto                   # Ausgabe

lotto = replicate(100000, sample(1:49, 6))  # 100000 mal ziehen bzw. 100000 Tipps
ziehung = sample(1:49, 6)                   # und z.B. die Mittwochsziehung

freq = table(apply(lotto, 2, function(x) sum(x %in% ziehung)))  # auswerten					

freq                            # mal schauen wer gewonnen hat
barplot(freq)                   # als plot
?sample

### elementare Ausdrücke:
3+4
3*4
3**4
3/4
10%%3
sqrt(2)

### Variablen: =  _  <-
x = 3; y = 4
x+y
y <- 10
y
#(Empfehlung: nur mehrbuchstabige Variablen verwenden. 
# Ausnahmen: x,y,z! Und ggf. kein "_" , sondern "." als Trenner)

### Modes: numeric character logical
mode(3+4)
mode("3+4")
mode(3+4 == 5)
3+4 == 5
T
F

### Vektoren und Vektorarithmetik
x = c(1,2,3,8,9,10)
x
y = c(2,2,3,2,3,4)
y
x+y
x-y
x*y
x/y
x*c(1,2)
c()
rep(c(5,7), 3)
5:10
10:5
seq(from=5, along=y)
seq(from=5, along=c())
length(x)

### Vektorindizierung
x
y
x[6]
y[6]
x[y]
y >= 3
y[y>=3]
x[-2]
x[-y]

#Uebung:Hole jedes zweite Element eines langen Vektors
x[2*(1:(length(x)/2))]
x[c(F,T)]

### Matrizen
x = c(4,5,6)
y = c(7,8,9)
cbind(x,y)
matr = rbind(x,y)
matr
nrow(matr)
ncol(matr)
dim(matr)
attr(matr,"dim")
attributes(matr)
matr[2,1]
matr[,2]
matr[,-2]
matr[,c(1,3)]
matr["x",]
matr[2]
as.vector(matr)

### Listen:
xy=list(eins=x,zwei=y)
xy
mode(xy)
names(xy)
xy[2]
xy[[2]]
xy[["zwei"]]
xy$zwei
mode(xy$zwei)
?"["
list(eins=5:9, zwei="ein String", raetsel=matr)
as.data.frame(xy)
as.list(as.data.frame(xy))
attributes(as.data.frame(xy))

### Objektorientierung (angedeutet):
methods("print")

### besondere Werte: Inf NaN NA NULL
3/0
Inf-Inf
NA
nana = x; nana[8] = 66; nana
c()

### Schleifen sind nur selten nötig:
xy
lapply(xy, sum)
sapply(xy, sum)
xy=rbind(xy$eins, xy$zwei)
xy
apply(xy, 1, sum)
apply(xy, 2, sum)

### Funktionen:
jitter(xy)
jitter
legal.level = function(dat, levels=5) dat>=1 && dat<=levels && dat==trunc(dat)
legal.level(4)
legal.level(6)
legal.level(4.1)
x
legal.level(x)
c(T,F) && T
c(T,F) & T
legal.level = function(dat, levels=5) dat>=1 & dat<=levels & dat==trunc(dat)
legal.level(x)
xy=rbind(x,y)
apply(xy, 1, function(x, lev) all(legal.level(x,lev)), lev=7)

### jetzt nochmal das Beispiel von oben:
lotto = replicate(3, sample(1:49, 6))	# 3 maliges Stickprobeziehen:
 
lotto                   # Ausgabe

lotto = replicate(100000, sample(1:49, 6))  # 100000 mal ziehen bzw. 100000 Tipps
ziehung = sample(1:49, 6)                   # und z.B. die Mittwochsziehung

freq = table(apply(lotto, 2, function(x) sum(x %in% ziehung)))  # auswerten					

freq                            # mal schauen wer gewonnen hat
barplot(freq)                   # als plot

### Dokumentation:
?sample
help("sample")
args(sample)
help.search("sample")
help.start()

### Ende:
q()



