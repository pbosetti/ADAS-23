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
