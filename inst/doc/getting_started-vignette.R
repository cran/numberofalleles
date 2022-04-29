## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(numberofalleles)
library(ggplot2)

freqs <- read_allele_freqs(system.file("extdata","FBI_extended_Cauc.csv", 
                                       package = "numberofalleles"))

gf_loci <- c("D3S1358", "vWA", "D16S539", "CSF1PO", "TPOX", "D8S1179", "D21S11", 
             "D18S51", "D2S441", "D19S433", "TH01", "FGA", "D22S1045", "D5S818", 
             "D13S317", "D7S820", "SE33", "D10S1248", "D1S1656", "D12S391", 
             "D2S1338")

## ----TAC----------------------------------------------------------------------
p_by_n <- list()

for (i in 1:6){
  p <- pr_total_number_of_distinct_alleles(contributors = paste0("U", seq(i)), 
                                           freqs = freqs, loci = gf_loci)
  
  p_by_n[[i]] <- data.frame(n = factor(i),
             number_of_alleles = p$noa,
             p = p$pf)
}

## ----fig.asp = 0.4, fig.width = 7---------------------------------------------
ggplot(subset(do.call(rbind, p_by_n), p > 1e-5)) + 
  aes(x = number_of_alleles, y = p, colour = n) + 
  geom_point() + geom_line() + xlim(0, 150) + theme_bw()

