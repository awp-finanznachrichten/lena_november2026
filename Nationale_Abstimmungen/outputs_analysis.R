###ANALYSIS GEMEINDEN###
output_analysis_gemeinden <- results %>%
  select(Gemeinde_d,
         Ja_Stimmen_In_Prozent,
         Hist_Ja_Stimmen_In_Prozent) %>%
  na.omit()

output_analysis_gemeinden$Ja_Stimmen_In_Prozent <- round2(output_analysis_gemeinden$Ja_Stimmen_In_Prozent,1)
output_analysis_gemeinden$Hist_Ja_Stimmen_In_Prozent <- round2(output_analysis_gemeinden$Hist_Ja_Stimmen_In_Prozent,1)

output_analysis_gemeinden$resultat <- ifelse(output_analysis_gemeinden$Ja_Stimmen_In_Prozent >= 50,
                                             "AHV-Finanzierung angenommen",
                                             "AHV-Finanzierung abgelehnt")

write.csv(output_analysis_gemeinden,paste0("Output_Analysis/",vorlagen_short[i],"_analysis_gemeinden.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")



###ANALYSIS KANTONE####
  