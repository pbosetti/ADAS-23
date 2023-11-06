# Lezione del 19/09/2023

# Definizione di una funzione:
f1 <- function(a, product=TRUE) {
  if (product) {
    return(a*3)
  } else {
    return(a/3)
  }
}

# Campionamento di un vettore:
set.seed(0) # rende ripetibile la generazione di numeri casuali
s <- 1:15
sample(s, 5)

sample(s, 10, replace = T)

# rimescolamento casuale:
sample(1:10)
# più semplicemente:
sample(10)

# Resistenza filato: preparazione tabella
# livelli
lvl <- seq(15, 35, 5)
# ripetizioni
r <- 5
# griglia delle possibili combinazioni livelli-ripetizioni
df <- expand.grid(Ripetizione=1:r, Cotone=lvl)
# colonna numeri casuali
df$ordine <- sample(length(df$Cotone))
# ordino in sequenza casuale
df <- df[order(df$ordine),]
# aggiungo colonna vuota per il risultato
df$resistenza <- NA
# esportiamo la tabella in un file di testo
write.csv2(df, file="test.csv")
write.csv(df, file="test.csv", row.names=F)
# lettura del file dopo le modifiche
df2 <- read.csv("test.csv")

# Riempire l'ultima colonna con numeri casuali normali
df$resistenza <- rnorm(length(df$Ripetizione), 10, 2)

by(df$resistenza, INDICES=df$Cotone, FUN=mean)

aggregate(df$resistenza ~ df$Cotone, FUN=mean)

aggregate(resistenza ~ Cotone, data=df, FUN=mean)

with(airquality,
     table(OzHi = Ozone > 80, Month, useNA="no")
)
