suppressPackageStartupMessages(require(getopt))
suppressPackageStartupMessages(require(tidyverse))
suppressPackageStartupMessages(require(vcfR))

spec <-
  matrix(
    c("input",    "i", 1, "character", 
      "output",   "o", 1, "character"), 
    ncol = 4,
    byrow = TRUE )
opt <- getopt(spec)


#opt <- tibble(input="/icgc/dkfzlsdf/analysis/OE0219_projects/nanopore/NanoMethPhase/AR/phased_short_read_AR.vcf")

input <- read.vcfR(opt$input)

fix <- input@fix %>% as_tibble() %>%
  
  mutate(CHROM=case_when(
    
    CHROM=="1" ~ "NC_000001.11",
    CHROM=="2" ~ "NC_000002.12",
    CHROM=="3" ~ "NC_000003.12",
    CHROM=="4" ~ "NC_000004.12",
    CHROM=="5" ~ "NC_000005.10",
    CHROM=="6" ~ "NC_000006.12",
    CHROM=="7" ~ "NC_000007.14",
    CHROM=="8" ~ "NC_000008.11",
    CHROM=="9" ~ "NC_000009.12",
    CHROM=="10" ~ "NC_000010.11",
    CHROM=="11" ~ "NC_000011.10",
    CHROM=="12" ~ "NC_000012.12",
    CHROM=="13" ~ "NC_000013.11",
    CHROM=="14" ~ "NC_000014.9",
    CHROM=="15" ~ "NC_000015.10",
    CHROM=="16" ~ "NC_000016.10",
    CHROM=="17" ~ "NC_000017.11",
    CHROM=="18" ~ "NC_000018.10",
    CHROM=="19" ~ "NC_000019.10",
    CHROM=="20" ~ "NC_000020.11",
    CHROM=="21" ~ "NC_000021.9",
    CHROM=="22" ~ "NC_000022.11",
    CHROM=="X" ~ "NC_000023.11",
    CHROM=="Y" ~ "NC_000024.10",
    
  )) %>% as.matrix()

## chamnge header

header <- input@meta

fixed_header <- header %>%
  
  str_replace("contig=<ID=1,", "contig=<ID=NC_000001\\.11,") %>%
  str_replace("contig=<ID=2,", "contig=<ID=NC_000002\\.12,") %>%
  str_replace("contig=<ID=3,", "contig=<ID=NC_000003\\.12,") %>%
  str_replace("contig=<ID=4,", "contig=<ID=NC_000004\\.12,") %>%
  str_replace("contig=<ID=5,", "contig=<ID=NC_000005\\.10,") %>%
  str_replace("contig=<ID=6,", "contig=<ID=NC_000006\\.12,") %>%
  str_replace("contig=<ID=7,", "contig=<ID=NC_000007\\.14,") %>%
  str_replace("contig=<ID=8,", "contig=<ID=NC_000008\\.11,") %>%
  str_replace("contig=<ID=9,", "contig=<ID=NC_000009\\.12,") %>%
  str_replace("contig=<ID=10,", "contig=<ID=NC_000010\\.11,") %>%
  str_replace("contig=<ID=11,", "contig=<ID=NC_000011\\.10,") %>%
  str_replace("contig=<ID=12,", "contig=<ID=NC_000012\\.12,") %>%
  str_replace("contig=<ID=13,", "contig=<ID=NC_000013\\.11,") %>%
  str_replace("contig=<ID=14,", "contig=<ID=NC_000014\\.9,") %>%
  str_replace("contig=<ID=15,", "contig=<ID=NC_000015\\.10,") %>%
  str_replace("contig=<ID=16,", "contig=<ID=NC_000016\\.10,") %>%
  str_replace("contig=<ID=17,", "contig=<ID=NC_000017\\.11,") %>%
  str_replace("contig=<ID=18,", "contig=<ID=NC_000018\\.10,") %>%
  str_replace("contig=<ID=19,", "contig=<ID=NC_000019\\.10,") %>%
  str_replace("contig=<ID=20,", "contig=<ID=NC_000020\\.11,") %>%
  str_replace("contig=<ID=21,", "contig=<ID=NC_000021\\.9,") %>%
  str_replace("contig=<ID=22,", "contig=<ID=NC_000022\\.11,") %>%
  str_replace("contig=<ID=X,", "contig=<ID=NC_000023\\.11,") %>%
  str_replace("contig=<ID=Y,", "contig=<ID=NC_000024\\.10,")
  





input@fix <- fix

input@meta <- fixed_header

write.vcf(input, file=opt$output)







