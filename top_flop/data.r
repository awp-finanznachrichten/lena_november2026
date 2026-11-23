#kantonwappen by benno
kanton_wappen_raw <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/11ubsMMA94G-aRhz7e3mganRLKzqEzfK1UgJ4e2h-RNE/edit?gid=0#gid=0")

#resp. envi.
link_1 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_november2026/refs/heads/main/Output_Switzerland/CH_AHV_Finanzierung_all_data.csv"

#imposition [[MODIFIER ENCORE]]
link_2 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_november2026/refs/heads/main/Output_Switzerland/CH_Ehepaarbesteuerung_all_data.csv"

#feux artifice [[MODIFIER ENCORE]]
link_3 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_november2026/refs/heads/main/Output_Switzerland/CH_Feuerwerk_all_data.csv"

#matériel de guerre [[MODIFIER ENCORE]]
link_4 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_november2026/refs/heads/main/Output_Switzerland/CH_Kriegsmaterial_all_data.csv"

#link_5 <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_maerz2026/refs/heads/main/Output_Switzerland/CH_SRG_all_data.csv"

obj_1 <- read_csv(link_1)

obj_2 <- read_csv(link_2)

obj_3 <- read_csv(link_3)

obj_4 <- read_csv(link_4)

#obj_5 <- read_csv(link_5)
