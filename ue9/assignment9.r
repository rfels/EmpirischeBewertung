NE=c(5,9,13,9,8,4,2)
AD=c(0,3,5,9,12,18,21)
x = data.frame(AD,NE)

mean(c(mapply(rep, x$AD,x$NE),recursive=TRUE))
median(c(mapply(rep, x$AD,x$NE),recursive=TRUE))

quantile(c(mapply(rep, x$AD,x$NE),recursive=TRUE),probs=(3/4))
quantile(c(mapply(rep, x$AD,x$NE),recursive=TRUE),probs=(9/10))


employes <- c(mapply(rep, x$AD,x$NE),recursive=TRUE)
mad(employes,center=mean(employes))
var(employes)
sd(employes)
sum(tail(employes,8))/sum(employes)


# signifficant result bedeutet, dass die Wahrscheinlichkeit, dass der Zufall
#das beobachtetet Ergebnis erzeugt gering ist (p≤0.5 ist eine typische, aber
#nicht starre Regel).

# Big effect wird über den Korrelationscoeffizienten bestimmt. Manche quellen
# geben 0.5 manche 0.8 als big an.
# In jedem Fall sind auch dies nur grobe Richtwerte.


