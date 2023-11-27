# Creo un Daniel plot
dp <- function(model, alpha=0.5, xlim=c(-3,3)) {
  e <- effects(model)
  tibble(
    term = names(e),
    value = as.numeric(e)
  ) %>%
    slice_tail(n=length(e) - 1) %>%
    ggplot(aes(sample=value)) +
    stat_qq() +
    geom_qq_line() +
    geom_label(aes(y=value, x=xlim[1], label=term), hjust="left", alpha=alpha) +
    geom_hline(aes(yintercept=value), alpha=alpha) +
    coord_cartesian(xlim=xlim)
}

# Plot per analisi residui
# Attenzione: !!sym(f) significa: "prendi la stringa f e convertila in un simbolo utilizzabile nelle estetiche ggplot"
rp <- function(t, f) t %>% ggplot(aes(x=!!sym(f), y=resid)) + geom_point()

# Grafico di Pareto
pareto_chart <- function(model) {


  df <- tibble(
    fattore=names(effects(model)),
    effetto=as.numeric(abs(effects(model)))
  ) %>%
    filter(fattore!="" & fattore != "(Intercept)") %>%
    arrange(desc(effetto)) %>%
    mutate(
      cum=cumsum(effetto),
      fattore=factor(fattore, ordered=T, levels=fattore)
    )

  df %>%
    ggplot(aes(x=fattore, group=1)) +
    geom_col(aes(y=effetto)) +
    geom_line(aes(y=cum)) +
    geom_point(aes(y=cum)) +
    scale_y_continuous(
      sec.axis = sec_axis(
        \(x) scales::rescale(x, from=c(0, max(df$cum)), to=c(0, 100)),
        name="Contributo relativo (%)",
        breaks=seq(0, 100, 10)
      )
    )
}
