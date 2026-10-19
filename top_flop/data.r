#kantonwappen by benno
kanton_wappen_raw <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/11ubsMMA94G-aRhz7e3mganRLKzqEzfK1UgJ4e2h-RNE/edit?gid=0#gid=0")

#resp. envi.
link_1 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_september2026/refs/heads/main/Output_Switzerland/CH_Neutralitaet_all_data.csv"

link_2 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_september2026/refs/heads/main/Output_Switzerland/CH_Ernaehrung_all_data.csv"

#link_3 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_maerz2026/refs/heads/main/Output_Switzerland/CH_Individualbesteuerung_all_data.csv"

#link_4 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_maerz2026/refs/heads/main/Output_Switzerland/CH_Klimafonds_all_data.csv"

#link_5 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_maerz2026/refs/heads/main/Output_Switzerland/CH_SRG_all_data.csv"

obj_1 <- read_csv(link_1)

obj_2 <- read_csv(link_2)

#obj_3 <- read_csv(link_3)

#obj_4 <- read_csv(link_4)

#obj_5 <- read_csv(link_5)
