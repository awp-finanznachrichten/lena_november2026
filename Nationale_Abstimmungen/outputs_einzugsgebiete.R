###Output generieren für Datawrapper Appenzell
output_dw_appenzell <- results[results$Kanton_Short == "AI" |
                                 results$Kanton_Short == "AR",]

output_dw_appenzell <- get_output_gemeinden(output_dw_appenzell,language = "de")

write.csv(output_dw_appenzell,paste0("Output_Regions/",vorlagen_short[i],"_dw_appenzell.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")

###Output generieren für Datawrapper ZOL
output_dw_ZOL <- results %>%
  filter(Gemeinde_Nr %in% 111:121 |
           Gemeinde_Nr %in% 172:200 |
           Gemeinde_Nr == 226 |
           Gemeinde_Nr == 228 |
           Gemeinde_Nr == 231 |
           Gemeinde_Nr == 296 |
           Gemeinde_Nr == 297)

output_dw_ZOL <- get_output_gemeinden(output_dw_ZOL,language = "de")
write.csv(output_dw_ZOL,paste0("Output_Regions/",vorlagen_short[i],"_dw_ZOL.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")

